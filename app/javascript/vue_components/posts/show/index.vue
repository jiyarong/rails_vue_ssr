<template>
  <div class="post-show-container">
    <div class="post-title">
      {{this.title}}
      <div class="edit-area" v-if="$store.state.hasLogin">
        <router-link :to="'/posts/edit/' + this.$route.params.id" >
          <button style="background: burlywood">
            <v-icon name="edit"></v-icon>
          </button>
        </router-link>
        <button style="background: crimson">
          <v-icon name="trash-alt"></v-icon>
        </button>
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

  export default {
    data () {
      return {
        title: "",
        content: ""
      }
    },
    beforeMount () {
      fetch(`/api/posts/${this.$route.params.id}`).then((response) => {
        if (response.ok) {
          return response.json()
        }
      }).then((data) => {
        this.title = data.title;
        this.content = data.content;
      });
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