<template>
    <div class="container">
      <head-menu>
        <item color="antiquewhite" routerLink="/">
          主页
<!--          <v-icon style="padding-top: 5px" name="home" scale="3"></v-icon>-->
        </item>

        <item color="antiquewhite" router-link="/posts">文章</item>

        <template>
          <item color="antiquewhite" direction="right" v-if="$store.state.hasLogin" href="/users/logout">
            <v-icon style="padding-right: 15px" name="sign-out-alt" scale="3"></v-icon>
          </item>
          <item color="antiquewhite" direction="right" v-else href="/users/login">
            <v-icon style="padding-right: 15px" name="sign-in-alt" scale="3"></v-icon>
          </item>
        </template>

        <item direction="right" color="antiquewhite" :group="[
          {name: '我这个人', routerLink: '/about/me'},
          {name: '这个博客', routerLink: '/about/this-blog'},
          {name: '我的简历', routerLink: '/about/resume'}
         ]">
          关于
        </item>
      </head-menu>

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
  import Homepage from './home_page'
  import PostList from './posts/index';
  import PostDetail from './posts/show';
  import newPost from './posts/new';
  import EditPost from './posts/edit';
  import aboutMe from './about/me';
  import aboutThisBlog from './about/this_blog';
  import aboutResume from './about/resume';
  import 'vue-awesome/icons/home'
  import 'vue-awesome/icons/sign-out-alt'
  import 'vue-awesome/icons/sign-in-alt'
  import Icon from 'vue-awesome/components/Icon'
  import "normalize.css";
  import './application.scss'
  import HeadMenu from './layouts/header';
  import Item from './layouts/item';

  const routes = [
    {
      path: '/',
      component: Homepage,
      name: 'home_page',
      props: true
    },
    {
      path: '/posts',
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
    },
    {
      path: '/about/me',
      component: aboutMe,
      name: 'about_me'
    },
    {
      path: '/about/this-blog',
      component: aboutThisBlog,
      name: 'about_this_blog'
    },
    {
      path: '/about/resume',
      component: aboutResume,
      name: 'about_resume'
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
      'v-icon': Icon,
      'item': Item,
      HeadMenu
    }
  };
</script>

<style scoped>
 .container {
   width: 100%;
   margin-left: auto;
   margin-right: auto;
 }

 .content {
   padding-top: 55px;
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