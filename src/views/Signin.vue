<template lang="html">
  <section id="signin" class="ui container">
    <div class="ui attached message">
      <div class="header">
        Welcome to our site!
      </div>
      <p>Fill out the form below to sign-in a existed account</p>
    </div>
    <form id="logform" class="ui form attached fluid segment">
      <div class="field">
        <label>Email</label>
        <div class="ui left icon input">
          <i class="mail icon"></i>
          <input type="text" id="logemail" name="logemail" placeholder="Email">
        </div>
      </div>
      <div class="field">
        <label>Password</label>
        <div class="ui left icon input">
          <i class="lock icon"></i>
          <input type="password" id="logpassword" name="logpassword" placeholder="Password">
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
        msg: "Sign into your account"
      }
    },
    mounted: function() {
      let logvue = this
      $.fn.api.settings.api = {
        'signin users': 'https://sneakerfans.herokuapp.com/api/v1/sessions'
      };

      $('form#logform')
        .form({
          on: 'blur',
          fields: {
            email: {
              identifier: 'logemail',
              rules: [{
                type: 'email',
                prompt: 'Please enter a valid email '
              }]
            },
            password: {
              identifier: 'logpassword',
              rules: [{
                type: 'empty',
                prompt: 'Password must have an value'
              }]
            }
          }
        })
        .api({
          action: 'signin users',
          method: 'post',
          dataType: 'JSON',
          beforeSend: (settings) => {
            let email = $('#logemail')[0].value
            let password = $('#logpassword')[0].value
            settings.data = {
              email: email,
              password: password
            }
            return settings;
          },
          onSuccess: (response) => {
            console.log(response)
            Cookies.set('user_name', response.session.name);
            Cookies.set('user_token', response.session.token, {
              // 30mins
              expires: 1 / 48
            });
            logvue.$root.$emit('loginsuccess', response.session)
            logvue.$root.$router.push('/')
          },
          onError: (errorMessage, element, xhr) => {
            if (xhr.status == 401) {
              $('form#logform').form('add errors', ['email and password don\'t match'])
            } else if (xhr.status == 500) {
              $('form#logform').form('add errors', ['email don\'t exist'])
            }
          }
        });
      $('form#logform')
        .keypress((event) => {
          if (event.which == 13) {
            event.preventDefault();
          }
        });
    },
    methods: {}
}
</script>
<style scope>
.content {
  padding-top: 10px;
  padding-bottom: 10px;
}

.ui .input {
  margin-bottom: 10px;
  width: 100%;
}
</style>
