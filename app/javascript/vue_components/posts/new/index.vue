<template>
  <post-form
    :initialTitle="this.title"
    :initialContent="this.content"
    :autoSave="true"
    :onSubmit="this.submitPost" />
</template>

<script>
  import PostForm from '../_form/index'

  export default {
    props: ['outside'],
    data () {
      return {
        title: "",
        content: ""
      }
    },
    methods: {
      submitPost (title, content) {
        return new Promise((resolve, reject) => {
          if (title === "") {
            alert("标题不能为空!");
            return reject();
          }

          fetch("/api/posts", {
            method: "POST",
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
            } else {
              return reject()
            }
          }).then((data) => {
            if (data.success) {
              alert("新建成功!");
              this.$router.push("/");
              return resolve()
            } else {
              alert(data.msg);
              return reject()
            }
          })
        });
      }
    },
    components: {
      PostForm
    }
  }
</script>
