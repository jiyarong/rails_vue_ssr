<template>
  <post-form
    v-if="!loading"
    :initialTitle="this.title"
    :initialContent="this.content"
    :onSubmit="this.submitPost" />
  <div v-else>加载中...</div>
</template>

<script>
  import PostForm from '../_form/index'

  export default {
    props: ['outside'],
    data () {
      return {
        title: "",
        content: "",
        loading: true
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
        this.loading = false
      });
    },

    methods: {
      submitPost (title, content) {
        return new Promise((resolve, reject) => {
          if (title === "") {
            alert("标题不能为空!");
            return reject()
          }

          fetch(`/api/posts/${this.$route.params.id}`, {
            method: "PUT",
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
              'X-CSRF-Token': this.outside.csrf_token
            },
            body: JSON.stringify({
              post: {title: title, content: content}
            })
          }).then((response) => {
            if (response.ok) {
              return response.json()
            }
          }).then((data) => {
            if (data.success) {
              alert("更新成功!");
              this.$router.push(`/posts/${this.$route.params.id}`)
              return resolve()
            } else {
              alert(data.msg);
              return reject()
            }
          })
        })

      },
    },
    components: {
      PostForm
    }
  }
</script>
