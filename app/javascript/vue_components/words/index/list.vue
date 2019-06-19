<template>
  <div class="word-list">
    <template v-for="word in words">
      <div class="word-item">
        <div class="word-item-info">
          <h2>{{word.text}}</h2>
          <div>{{word.result}}</div>
          <div v-for="d in word.dict">
            {{d}}
          </div>
          <a :href="word.link" target="_blank">{{word.link}}</a>
        </div>
        <div v-if="$store.state.hasLogin" class="word-item-edit">
          <button @click="() => {updateWord(word, 1)}" v-if="word.status === 0">确认</button>
          <button @click="() => {updateWord(word, 0)}" v-if="word.status === 1">重新确认</button>
        </div>
      </div>
    </template>
  </div>
</template>

<script>
  import { updateWordStatus } from  "../../../src/api";

  export default {
    props: ['words'],
    methods: {
      updateWord(word, status) {
        updateWordStatus(word.id, status).then((data) => {
          if (data.msg === "ok") {
            this.$emit('wordUpdate', word)
          }
        })
      }
    }
  }
</script>