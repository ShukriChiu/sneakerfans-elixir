<template lang="html">
  <section class="ui container">
    <div class="ui attached message">
      <div class="header">
        Upload Articles here
      </div>
      <p>Upload images first </p>
    </div>
    <form id="articleForm" class="ui form attached fluid segment">
      <div class="field">
        <label>Article Title</label>
        <div class="ui input">
          <input type="text" placeholder="Article Title">
        </div>
      </div>
      <div class="field">
        <label>Article Techs</label>
        <select id="techs" name="regtechs" class="ui fluid search hidden dropdown" multiple="">
        </select>
      </div>
    </form>
    <textarea></textarea>
    <button class="ui button">submit</button>
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
      let simplemde = new SimpleMDE()
    }
}
</script>
<style scope>
</style>
