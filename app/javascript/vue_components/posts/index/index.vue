<template>
  <keep-alive>
    <div class="posts">
      <post-list :posts="posts"></post-list>

      <infinite-loading v-if="!this.env_ssr" @infinite="infiniteHandler">
        <div slot="no-more">No more posts. </div>
        <div slot="no-results">No results message. </div>
      </infinite-loading>
    </div>
  </keep-alive>
</template>

<script>
  import "./index.scss"
  import InfiniteLoading from 'vue-infinite-loading';
  import 'vue-awesome/icons/edit'
  import 'vue-awesome/icons/trash-alt'
  import Icon from 'vue-awesome/components/Icon'
  import { getPosts } from "../../../src/api";
  import PostList from './list'

  export default {
    props: ['outside', 'env_ssr'],
    data () {
      return {
        posts: (this.outside && this.outside.posts) || [],
        page: 1,
        loading: false
      }
    },
    methods: {
      infiniteHandler($state) {
        getPosts(this.page + 1).then((data) => {
          console.log(data);
          this.posts.push(...data.posts);
          this.page += 1;
          if (data.last_page) {
            $state.complete();
          } else {
            $state.loaded()
          }
        })
      }
    },
    components: {
      'infinite-loading': InfiniteLoading,
      'v-icon': Icon,
      'post-list': PostList
    }
  }
</script>