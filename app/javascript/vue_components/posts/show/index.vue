<template>
  <div class="post-show-container">
    <div class="post-title">
      {{this.title}}
      <div class="post-tags">
        <template v-for="tag in this.tags">
          <span>{{tag.name}}</span>
        </template>
      </div>
      <div class="edit-area" v-if="$store.state.hasLogin">
        <router-link :to="'/posts/edit/' + this.id" >
          <button style="background: burlywood">
            <v-icon name="edit"></v-icon>
          </button>
        </router-link>
<!--        <button style="background: crimson">-->
<!--          <v-icon name="trash-alt"></v-icon>-->
<!--        </button>-->
      </div>
    </div>
    <div class="post-content">
      <vue-markdown :source="this.content"></vue-markdown>
    </div>
  </div>
</template>

<script>
  import VueMarkdown from 'vue-markdown'
  import Prism from 'prismjs';
  import 'prismjs/themes/prism.css';
  import 'vue-awesome/icons/edit'
  import 'vue-awesome/icons/trash-alt'
  import Icon from 'vue-awesome/components/Icon'
  import "./index.scss"
  import { getPost } from "../../../src/api";

  export default {
    props: ['outside', 'env_ssr'],

    data () {
      return {
        title: "",
        content: "",
        tags: [],
        id: this.$route.params.id
      }
    },
    created () {
      if (this.outside && this.outside.post != undefined) {
        let post = this.outside.post;
        this.title = post.title;
        this.content = post.content;
        this.tags = post.tags;
        this.id = post.id;
        this.outside.post = undefined;
      } else {
        if (!this.env_ssr) {
          getPost(this.id).then((data) => {
            this.title = data.title;
            this.content = data.content;
            this.tags = data.tags
          });
        }
      }
    },

    mounted () {
      Prism.highlightAll();
    },

    updated () {
      Prism.highlightAll();
    },
    methods: {
      prerender()  {
        return this.content
      }
    },
    components: {
      VueMarkdown,
      'v-icon': Icon
    }
  }
</script>