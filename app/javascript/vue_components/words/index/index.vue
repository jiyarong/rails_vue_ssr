<template>
  <div class="words-container">
    <div class="word-tabs">
      <div :class="`word-tab ${status === '' ? 'active' : ''}`" @click="() => {this.setStatus('')}">全部</div>
      <div :class="`word-tab ${status === 0 ? 'active' : ''}`" @click="() => {this.setStatus(0)}">未确认</div>
      <div :class="`word-tab ${status === 1 ? 'active' : ''}`" @click="() => {this.setStatus(1)}">已确认</div>
    </div>
    <word-list @wordUpdate="wordUpdate" :words="words"></word-list>
    <infinite-loading v-if="!this.env_ssr" @infinite="infiniteHandler">
      <div slot="no-more">No more words. </div>
      <div slot="no-results">No results message. </div>
    </infinite-loading>
  </div>
</template>

<script>
  import { getWords } from "../../../src/api";
  import WordList from './list';
  import './index.scss';

  export default {
    props: ['env_ssr'],
    data () {
      return {
        words: [],
        page: 0,
        status: ""
      }
    },
    mounted () {
      this.infiniteHandler()
    },
    methods: {
      setStatus(newStatus) {
        this.status = newStatus;
        this.page = 0;
        this.words = [];
        this.infiniteHandler()
      },

      wordUpdate(word) {
        this.words = this.words.filter((w) => {
          return w.id !== word.id;
        })
      },

      infiniteHandler($state) {
        getWords(this.page + 1, this.status).then((data) => {
          this.words.push(...data.words);
          this.page += 1;
          if ($state) {
            if (data.last_page) {
              $state.complete();
            } else {
              $state.loaded()
            }
          }
        })
      }
    },
    components: { WordList }
  }
</script>