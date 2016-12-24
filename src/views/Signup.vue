<template lang="html">
  <section id="signup" class="ui container">
    <div class="ui attached message">
      <div class="header">
        Welcome to our site!
      </div>
      <p>Fill out the form below to sign-up for a new account</p>
    </div>
    <form id="regform" class="ui form attached fluid segment">
      <div class="field">
        <label>Email</label>
        <div class="ui left icon input">
          <i class="mail icon"></i>
          <input type="text" id="regemail" name="regemail" placeholder="Email">
        </div>
      </div>
      <div class="field">
        <label>Name</label>
        <div class="ui left icon input">
          <i class="user icon"></i>
          <input type="text" id="regname" name="regname" placeholder="Name">
        </div>
      </div>
      <div class="field">
        <label>Password</label>
        <div class="ui left icon input">
          <i class="lock icon"></i>
          <input type="password" id="regpassword" name="regpassword" placeholder="Password">
        </div>
      </div>
      <div class="field">
        <label>Shoe brands</label>
        <div class="ui grid">
          <div class="four wide column">
            <select id="brands" name="regbrands" class="ui fluid search selection dropdown"></select>
          </div>
          <div v-show="tech" class="twelve wide column">
            <select id="techs" name="regtechs" class="ui fluid search hidden dropdown" multiple="">
            </select>
          </div>
        </div>
      </div>
      <div class="inline field">
        <div class="ui checkbox">
          <input type="checkbox" id="terms" name="regterms">
          <label for="terms">I agree to the terms and conditions</label>
        </div>
      </div>
      <div class="ui blue submit button">Submit</div>
      <div class="ui clear button">Clear</div>
      <div class="ui error message"></div>
    </form>
  </section>
</template>
<script>
export default {
  data() {
      return {
        tech: false,
        eamil_validation: true
      }
    },
    mounted: function() {
      sessionStorage.clear();
      let regvue = this
      $.fn.api.settings.api = {
        'signup users': 'https://sneakerfans.herokuapp.com/api/v1/users'
      };
      $('form#regform')
        .form({
          on: 'blur',
          fields: {
            email: {
              identifier: 'regemail',
              rules: [{
                type: 'email',
                prompt: 'Please enter a valid email '
              }]
            },
            name: {
              identifier: 'regname',
              rules: [{
                type: 'empty',
                prompt: 'Name must have an value'
              }, {
                type: 'maxLength[15]',
                prompt: 'Please enter at most 15 characters'
              }]
            },
            password: {
              identifier: 'regpassword',
              rules: [{
                type: 'empty',
                prompt: 'Password must have an value'
              }, {
                type: 'minLength[6]',
                prompt: 'Password must be no less than 6 characters'
              }]
            },
            brands: {
              identifier: 'regbrands',
              rules: [{
                type: 'empty',
                prompt: 'must select at least a brand'
              }]
            },
            techs: {
              identifier: 'regtechs',
              rules: [{
                type: 'minCount[2]',
                prompt: 'must select at least two techs'
              }]
            },
            checkbox: {
              identifier: 'regterms',
              rules: [{
                type: 'checked',
                prompt: 'Terms must be reviewed and agreed'
              }]
            }
          }
        })
        .api({
          action: 'signup users',
          method: 'post',
          dataType: 'JSON',
          beforeSend: (settings) => {
            let email = $('#regemail')[0].value
            regvue.validate_mail(email)
            if (!regvue.eamil_validation) {
              return false
            } else {
              let name = $('#regname')[0].value
              let password = $('#regpassword')[0].value
              let techs_array = $('#techs').dropdown('get value')
              let techs = techs_array[techs_array.length - 1]
              settings.data = {
                email: email,
                name: name,
                password: password,
                techs: techs
              }
              return settings
            }
          },
          onSuccess: (response) => {
            console.log(response)
            Cookies.set('user_name', response.user.name);
            Cookies.set('user_token', response.user.token, {
              // 30mins
              expires: 1 / 48
            });
            regvue.$root.$emit('loginsuccess', response.user)
            regvue.$root.$router.push('/')
          },
          onError: (response) => {
            console.log(response)
          }
        });

      $('form#regform')
        .keypress((event) => {
          if (event.which == 13) {
            event.preventDefault();
          }
        });

      $('#brands')
        .dropdown({
          apiSettings: {
            url: 'https://sneakerfans.herokuapp.com/api/v1/allbrands',
          },
          fields: {
            remoteValues: 'brands',
            name: 'brand_name',
            value: 'id'
          },
          allowReselection: 'ture',
          placeholder: 'select brands',
          direction: 'downward',
          onChange: (value, text, $choice) => {
            regvue.brand_id = value
            if (!regvue.tech) {
              regvue.tech = true
            }
            $('#techs')
              .dropdown({
                placeholder: 'select techs',
                fields: {
                  remoteValues: 'techs',
                  name: "tech_name",
                  value: "id"
                },
                apiSettings: {
                  url: 'https://sneakerfans.herokuapp.com/api/v1/gettechs',
                  method: 'post',
                  beforeSend: (settings) => {
                    sessionStorage.removeItem('https://sneakerfans.herokuapp.com/api/v1/gettechs')
                    settings.data = {
                      brand_id: regvue.brand_id,
                    }
                    return settings
                  }
                },
                direction: 'downward',
                forceSelection: false
              });
          }
        });
    },
    methods: {
      validate_mail: function(email) {
        $.ajax({
          url: 'https://sneakerfans.herokuapp.com/api/v1/validate',
          method: 'post',
          async: false,
          data: {
            email: email
          },
          statusCode: {
            409: () => {
              $('form#regform').form('add errors', ['email already existed'])
              this.eamil_validation = false
            },
            200: () => {
              console.log("")
              this.eamil_validation = true
            }
          }
        });
      }
    }
}
</script>
<style scope>
</style>
