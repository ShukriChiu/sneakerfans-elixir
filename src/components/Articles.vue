<template lang="html">
  <section id="articles" class="ui container">
    <div id="cards" class="ui three doubling raised segment cards">
    </div>
  </section>
</template>
<script>
export default {
  data() {
      return {}
    },
    mounted: function() {
      let articlevue = this

      function generateCardsView(id, title, techs, picture, address) {
        let card = $("<div class=\"card\">")
        card.appendTo($("#cards"))
        let dimimage = $("<div class=\"blurring dimmable image\">")
        dimimage.appendTo(card)
        let dimui = $("<div class=\"ui dimmer\">")
        dimui.appendTo(dimimage)
        let sub_title = $("<div class=\"ui header sub_title\">")
        sub_title.append(title)
        sub_title.click(() => {
          articlevue.$root.$router.push('/post/' + id)
        })
        sub_title.appendTo(dimui)
        let sub_divider = $("<h4 class=\"ui horizontal divider header sub_divider\">")
        let tag = $("<i class=\"tag icon\"></i>")
        tag.appendTo(sub_divider)
        sub_divider.append('Techs')
        sub_divider.appendTo(dimui)
        let sub_techs = $("<div class=\"sub_techs\">")
        $.each(techs, (index, tech) => {
          $.ajax({
            url: 'https://sneakerfans.herokuapp.com/api/v1/techs/' + tech,
            method: 'get',
            success: (data) => {
              let tech_name = data.tech.tech_name
              let label = $("<div class=\"ui label\">")
              label.append(tech_name)
              label.appendTo(sub_techs)
            }
          });
        })
        sub_techs.appendTo(dimui)
        let image = $("<img>", {
          src: picture
        })
        image.appendTo(dimimage)
      }
      $.ajax({
        url: 'https://sneakerfans.herokuapp.com/api/v1/allarticles',
        method: 'get',
        success: (data) => {
          $.each(data.articles, (index, article) => {
            let id = article.id
            let title = article.title
            let techs = article.techs
            let picture = article.picture
            let address = article.address
            generateCardsView(id, title, techs, picture, address)
            $('#articles .cards .image').dimmer({
              on: 'hover'
            });
          })
        }
      });
    }
}
</script>
<style scope>
#articles {}

.ui.header.sub_title {
  color: white;
  padding-top: 2em;
}

.ui.header.sub_divider {
  color: white;
}

.dimmable.image>img {
  width: 347px;
  height: 248px !important;
}

.ui.header.sub_title:hover {
  cursor: pointer;
}
</style>
