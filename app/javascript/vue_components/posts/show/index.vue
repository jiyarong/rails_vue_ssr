<template>
  <div class="post-show-container">
    <div class="post-title">
      {{this.title}}
      <div class="edit-area" v-if="$store.state.hasLogin">
        <router-link :to="'/posts/edit/' + this.id" >
          <button style="background: burlywood">
            <v-icon name="edit"></v-icon>
          </button>
        </router-link>
      </div>

      <div class="post-tags">
        <template v-for="tag in this.tags">
          <span>{{tag.name}}</span>
        </template>
      </div>

    </div>
    <div class="post-content">
      <vue-markdown :postrender="this.postrender" :source="this.content"></vue-markdown>
    </div>
  </div>
</template>

<script>
  import VueMarkdown from 'vue-markdown'
  import Prism from 'prismjs';
  import 'prismjs/themes/prism.css';
  import 'vue-awesome/icons/edit'
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
      scrollTo(0,0);
      Prism.highlightAll();
    },
    updated () {
      Prism.highlightAll();
    },
    methods: {
      postrender (str) {
        return str.replace(/(href)/g, "target='_blank' $&")
      }
    },
    components: {
      VueMarkdown,
      'v-icon': Icon
    }
  }
</script>