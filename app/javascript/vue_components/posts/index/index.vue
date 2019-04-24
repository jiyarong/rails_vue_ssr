<template>
  <keep-alive>
    <div class="posts">
      <template v-for="post in posts">
        <div class="post-item">
          <router-link :to="'/posts/' + post.id" >
            <div class="post-item__title">
              <div class="title-area">
                <div class="title">{{post.title}}</div>
                <div class="post-item__tags">
                  <template v-for="tag in post.tags">
                    <span>{{tag.name}}</span>
                  </template>
                </div>
              </div>

              <div class="edit-area" v-if="$store.state.hasLogin">
                <router-link :to="'/posts/edit/' + post.id" >
                  <button style="background: burlywood">
                    <v-icon name="edit"></v-icon>
                  </button>
                </router-link>
                <!--<button style="background: crimson">-->
                  <!--<v-icon name="trash-alt"></v-icon>-->
                <!--</button>-->
              </div>
            </div>
          </router-link>
          <div class="post-item__updated_at">
            <span>{{post.updated_at}}</span>
          </div>
        </div>
      </template>
      <infinite-loading v-if="!this.env_ssr" @infinite="infiniteHandler">
        <div slot="no-more">No more posts</div>
        <div slot="no-results">No results message</div>
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
      'v-icon': Icon
    }
  }
</script>