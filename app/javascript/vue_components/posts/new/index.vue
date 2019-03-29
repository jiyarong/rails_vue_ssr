<template>
  <post-form
    :initialTitle="this.title"
    :initialContent="this.content"
    :autoSave="true"
    :onSubmit="this.submitPost" />
</template>

<script>
  import PostForm from '../_form/index';
  import { createPost } from "../../../src/api";

  export default {
    props: ['outside'],
    data () {
      return {
        title: "",
        content: ""
      }
    },
    methods: {
      submitPost (attributes) {
        return new Promise((resolve, reject) => {
          if (attributes.title === "") {
            alert("标题不能为空!");
            return reject();
          }

          createPost(attributes).then((data) => {
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
