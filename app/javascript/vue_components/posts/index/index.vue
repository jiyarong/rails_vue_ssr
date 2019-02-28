<template>
  <div class="posts">
    这里是文章列表
    <template v-for="post in outside.posts">
      <router-link :to="'/posts/' + post[0]" >
        <div>{{post[1]}}</div>
      </router-link>
    </template>
  </div>
</template>

<script>
  import "./index.scss"
  export default {
    props: ['outside'],
    data () {
      return {

      }
    }
  }
</script>