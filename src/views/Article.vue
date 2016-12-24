<template lang="html">
  <section id="article" class="ui container">
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
      console.log(this.$route.params.id)
      let url = 'https://sneakerfans.herokuapp.com/api/v1/articles/' + this.$route.params.id
      $.ajax({
        url: url,
        method: 'get',
        success: (data) => {
          let converter = new showdown.Converter()
          converter.setFlavor('github')
          console.log("The artcle address is converted from " + data.article.address)
          $.get(data.article.address, (data) => {
            html = converter.makeHtml(data)
            $('#article').append(html)
          })
        }
      });
    }
}
</script>
<style scope>
</style>
