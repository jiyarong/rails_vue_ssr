<template>
  <div>
    <div>
      <multi-select
        @tag="addTag"
        :block-keys="['Delete']"
        tag-placeholder="添加标签"
        placeholder="搜索或添加一个标签"
        :taggable="true"
        v-model="tags"
        :multiple="true"
        :options="tags_options"
        label="name"
        track-by="id" />
    </div>
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
      <input type="button" @click="submit" value="保存"/>
    </div>
  </div>
</template>

<script>
  import VueMarkdown from 'vue-markdown'
  import MultiSelect from 'vue-multiselect'
  import Prism from 'prismjs';
  import 'prismjs/themes/prism.css';
  import './index.scss'
  import 'vue-multiselect/dist/vue-multiselect.min.css'

  const unsaved_content_key = "LAST_UNSAVED_POST_CONTENT";

  export default {
    props: {
      initialTitle: String,
      initialContent: String,
      initialId: String,
      initialTags: {type: Array, default: undefined},
      onSubmit: Function,
      autoSave: {type: Boolean, default: false}
    },
    data() {
      return {
        title: this.initialTitle,
        content: this.initialContent,
        tags: this.initialTags || [],
        id: this.initialId,
        tags_options: []
      }
    },

    updated() {
      Prism.highlightAll();
    },

    mounted() {
      if (this.autoSave) {
        let _content = localStorage.getItem(this.unsavedContentKey());
        if (_content) {
          this.content = _content;
        }
      };
      Prism.highlightAll();
      this.fetchTags();
    },

    methods: {
      fetchTags() {
        fetch("/api/tags").then((response) => {
          if (response.ok) {
            return response.json()
          }
        }).then((data) => {
          this.tags_options.push(...data.tags);
        })
      },

      unsavedContentKey() {
        if (this.id) {
          return `${unsaved_content_key}_${this.id}`
        } else {
          return unsaved_content_key
        }
      },

      renderMd() {
        Prism.highlightAll();
        if (this.autoSave) {
          localStorage.setItem(this.unsavedContentKey(), this.content)
        }
      },

      addTag (t) {
        this.tags.push({name: t, id: null})
      },

      generateSubmitContent () {
        let tag_ids = this.tags.filter((t) => {
          return t.id !== null
        }).map((t) => {
          return t.id
        });

        let tags_attributes = this.tags.filter((t) => {
          return t.id === null
        });

        return {
          title: this.title,
          content: this.content,
          tag_ids,
          tags_attributes
        }
      },

      submit() {
        if (this.onSubmit !== undefined) {
          this.onSubmit(this.generateSubmitContent()).then(() => {
            if (this.autoSave) {
              localStorage.removeItem(this.unsavedContentKey())
            }
          })
        }
      }
    },

    components: {
      VueMarkdown,
      MultiSelect
    }
  }
</script>