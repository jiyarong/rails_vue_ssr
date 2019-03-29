<template>
    <div class="container">
      <div class="navigation-bar">
        <div class="dashboard">
          <router-link to="/">
            <v-icon name="home" scale="3"></v-icon>
          </router-link>
        </div>

        <div class="navigate-logout" v-if="$store.state.hasLogin">
          <a href="/users/logout">
            <v-icon name="sign-out-alt" scale="3"></v-icon>
          </a>
        </div>
        <div class="navigate-logout" v-else>
          <a href="/users/login">
            <v-icon name="sign-in-alt" scale="3"></v-icon>
          </a>
        </div>
      </div>
      <div class="content">
        <router-view v-bind="$attrs" :outside="outside" :env_ssr="env_ssr"></router-view>
      </div>
      <router-link to="/posts/new" v-if="$store.state.hasLogin && $route.path !== '/posts/new'" class="add-new">
        +
      </router-link>
    </div>
</template>

<script>
  import VueRouter from 'vue-router';
  import PostList from './posts/index';
  import PostDetail from './posts/show';
  import newPost from './posts/new';
  import EditPost from './posts/edit';
  import 'vue-awesome/icons/home'
  import 'vue-awesome/icons/sign-out-alt'
  import 'vue-awesome/icons/sign-in-alt'
  import Icon from 'vue-awesome/components/Icon'
  import "normalize.css";
  import './application.scss'

  const routes = [
    {
      path: '/',
      component: PostList,
      name: 'post_index',
      props: true
    },
    {
      path: '/posts/new',
      component: newPost,
      name: 'new_post'
    },
    {
      path: '/posts/edit/:id',
      component: EditPost,
      name: 'edit_post'
    },
    {
      path: '/posts/:id',
      component: PostDetail,
      name: 'post_detail'
    }
  ];

  const router = new VueRouter({
    mode: 'history',
    routes
  });

  export default {
    props: ['outside', 'env_ssr'],
    router,
    components: {
      'v-icon': Icon
    }
  };
</script>

<style scoped>


 .container {
   width: 100%;
 }

 .navigation-bar {
   position: fixed;
   height: 55px;
   width: 100vw;
   background: cadetblue;
   top: 0;
 }

 .dashboard {
   width: 50px;
   height: 100%;
   text-align: center;
   padding: 10px 0 0 20px;
   display: inline;
 }

 .navigate-logout {
   width: 50px;
   height: 100%;
   text-align: center;
   float: right;
   display: inline;
   padding-right: 20px;
 }

 .dashboard a, .navigate-logout a {
   color: antiquewhite;
 }

 .content {
   padding-top: 60px;
 }

 .add-new {
   position: fixed;
   right: 5%;
   bottom: 10%;
   background: rgba(67,69,249,0.95) ;
   text-align: center;
   line-height: 45px;
   width: 50px;
   height: 50px;
   border-radius: 25px;
   font-size: 2.5rem;
   color: #FFFFFF;
   text-decoration: none;
   opacity: 0.8;
 }

 /*.content {*/
   /*text-align: center;*/
 /*}*/
</style>