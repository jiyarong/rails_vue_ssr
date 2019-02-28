<template>
  <div>
    App
    <router-link to="foo">to foo</router-link>
    <div>
      <router-view></router-view>
    </div>
  </div>
</template>

<script>
  import VueRouter from 'vue-router';
  import Foo from './foo'
  //Vue.use(VueRouter);

  const routes = [
    { path: '/foo', component: Foo, name: 'foo' }
  ];

  const router = new VueRouter({
    mode: 'history',
    routes
  });
  export default {
    router,
    components: { Foo },
  };
</script>