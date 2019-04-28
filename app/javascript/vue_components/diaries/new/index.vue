<template>
  <div>
    <textarea class="diary-content" v-model="content" name="content" cols="30" rows="30"></textarea>
    <div class="submit-area">
      <input type="button" @click="submit" value="保存"/>
    </div>
  </div>
</template>

<script>
  import { createDiary } from '../../../src/api';
  export default {
    data () {
      return {
        content: ""
      }
    },
    methods: {
      submit () {
        createDiary({content: this.content}).then((data) => {
          console.log(data)
          if (data.success) {
            alert("新建成功!");
            this.$router.push("/");
          }
        })
      }
    }
  }
</script>

<style scoped>
  .diary-content{
    width: 100%;
  }

  .submit-area {
    text-align: center;
  }
</style>