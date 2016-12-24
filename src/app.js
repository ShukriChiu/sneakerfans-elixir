import Vue from 'vue'
import VueRouter from 'router'
import Index from './views/Index.vue'
import Signup from './views/Signup.vue'
import Signin from './views/Signin.vue'
import Headerbar from './components/Headerbar.vue'
import Articles from './components/Articles.vue'
import Article from './views/Article.vue'
import ArticleEdit from './views/Article_edit.vue'

Vue.use(VueRouter)

Vue.component('headerbar', Headerbar)
Vue.component('articles', Articles)
const router = new VueRouter({
  routes: [{
    path: '/',
    component: Index
  }, {
    path: '/signin',
    component: Signin
  }, {
    path: '/signup',
    component: Signup
  }, {
    path: '/post/:id',
    component: Article
  },{
    path: '/upload',
    component: ArticleEdit
  }]
})

const vm = new Vue({
  router: router
}).$mount('#index')
