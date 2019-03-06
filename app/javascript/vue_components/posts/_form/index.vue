<template>
  <div>
    <div class="new-posts-container">
      <div class="post-input">
        <div>
          <input placeholder="在此输入标题" type="text" v-model="title" class="post-title">
        </div>
        <div class="post-content">
          <textarea placeholder="在此输入内容" name="post-content" @keyup="renderMd" v-model="content"></textarea>
        </div>
      </div>
      <div class="post-preview">
        <div class="post-title">{{this.title}}</div>
        <vue-markdown :source="this.content"></vue-markdown>
      </div>
    </div>
    <div class="submit-area">
      <input type="button" @click="submit" value="保存" />
    </div>
  </div>
</template>

<script>
  import VueMarkdown from 'vue-markdown'
  import Prism from 'prismjs';
  import 'prismjs/themes/prism.css';
  import './index.scss'

  const unsaved_content_key = "LAST_UNSAVED_POST_CONTENT";

  export default {
    props: {
      initialTitle: String,
      initialContent: String,
      onSubmit: Function,
      autoSave: {type: Boolean, default: false}
    },
    data () {
      return {
        title: this.initialTitle,
        content: this.initialContent
      }
    },

    updated () {
      Prism.highlightAll();
    },

    mounted () {
      if (this.autoSave) {
        let _content = localStorage.getItem(unsaved_content_key);
        if (_content) {
          this.content = _content;
        }
      };
      Prism.highlightAll();
    },

    methods: {
      renderMd () {
        Prism.highlightAll();
        if (this.autoSave) {
          localStorage.setItem(unsaved_content_key, this.content)
        }
      },

      submit() {
        if (this.onSubmit !== undefined) {
          this.onSubmit(this.title, this.content).then(() => {
            if (this.autoSave) {
              localStorage.removeItem(unsaved_content_key)
            }
          })
        }
      }
    },

    components: {
      VueMarkdown
    }
  }
</script>