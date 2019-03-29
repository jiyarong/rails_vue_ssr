<template>
  <post-form
    v-if="!loading"
    :initialTitle="this.title"
    :initialContent="this.content"
    :initialTags="this.tags"
    :onSubmit="this.submitPost" />
  <div v-else>加载中...</div>
</template>

<script>
  import PostForm from '../_form/index'
  import { getPost, updatePost } from "../../../src/api";

  export default {
    props: ['outside'],
    data () {
      return {
        title: "",
        content: "",
        tags: [],
        loading: true
      }
    },
    beforeMount () {
      getPost(this.$route.params.id).then((data) => {
        this.title = data.title;
        this.content = data.content;
        this.tags = data.tags;
        this.loading = false
      });
    },

    methods: {
      submitPost (attributes) {
        return new Promise((resolve, reject) => {
          if (attributes.title === "") {
            alert("标题不能为空!");
            return reject()
          }

          updatePost(this.$route.params.id, {post: attributes}).then((data) => {
            if (data.success) {
              alert("更新成功!");
              this.$router.push(`/posts/${this.$route.params.id}`)
              return resolve()
            } else {
              alert(data.msg);
              return reject()
            }
          });
        })
      },
    },
    components: {
      PostForm
    }
  }
</script>
