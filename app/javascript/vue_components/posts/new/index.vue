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
      <input type="button" @click="submitPost" value="保存" />
    </div>
  </div>
</template>

<script>
  import VueMarkdown from 'vue-markdown'
  import Prism from 'prismjs';
  import 'prismjs/themes/prism.css';
  import './index.scss'

  export default {
    props: ['outside'],
    data () {
      return {
        title: "",
        content: ""
      }
    },
    mounted () {
      Prism.highlightAll();
    },
    methods: {
      submitPost () {
        if (this.title === "") {
          alert("标题不能为空!");
          return
        }

        fetch("/api/posts", {
          method: "POST",
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'X-CSRF-Token': this.outside.csrf_token
          },
          body: JSON.stringify({
            post: {title: this.title, content: this.content}
          })
        }).then((response) => {
          if (response.ok) {
            return response.json()
          }
        }).then((data) => {
          if (data.success) {
            alert("新建成功!");
            this.$router.push("/")
          } else {
            alert(data.msg)
          }
        })
      },

      renderMd () {
        Prism.highlightAll();
      }
    },
    components: {
      VueMarkdown
    }
  }
</script>
