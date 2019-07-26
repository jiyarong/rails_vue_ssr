<template>
  <div class="post-show-container">
    <div class="post-title">
      {{this.title}}
      <div class="edit-area" v-if="$store.state.hasLogin">
        <router-link :to="'/posts/edit/' + this.id">
          <button style="background: burlywood">
            <v-icon name="edit"></v-icon>
          </button>
        </router-link>
      </div>

      <div class="post-tags">
        <template v-for="tag in this.tags">
          <span>{{tag.name}}</span>
        </template>
      </div>

    </div>

    <div class="post-content-index">
      <div v-for="i_node in index_nodes" :class="`i_node_tag ${i_node.tagName}`" @click="() => {scrollToElement(`.${i_node.classList.value}`)}">
        {{i_node.textContent}}
      </div>
    </div>

    <div class="post-content">
      <vue-markdown @rendered="addContetIndex()" :postrender="this.postrender" :source="this.content"></vue-markdown>
    </div>

    <div v-if="!env_ssr" class="fb-comments-container">
      <div class="fb-comments" :data-href="`https://vblog.peterji.cn/posts/${id}`" data-width="" data-numposts="5"></div>
    </div>

    <viewer :images="images" @inited="inited">
      <img alt="" v-show="false" v-for="src in images" :src="src" :key="src">
    </viewer>
  </div>
</template>

<script>
  import VueMarkdown from 'vue-markdown'
  import Prism from 'prismjs';
  import 'prismjs/themes/prism.css';
  import 'vue-awesome/icons/edit'
  import Icon from 'vue-awesome/components/Icon'
  import "./index.scss"
  import {getPost} from "../../../src/api";
  import 'viewerjs/dist/viewer.css'
  import Viewer from "v-viewer/src/component.vue";

  export default {
    props: ['outside', 'env_ssr'],

    data() {
      return {
        title: "",
        content: "",
        tags: [],
        images: [],
        id: this.$route.params.id,
        index_nodes: []
      }
    },
    created() {
      if (this.outside && this.outside.post != undefined) {
        let post = this.outside.post;
        this.title = post.title;
        this.content = post.content;
        this.tags = post.tags;
        this.id = post.id;
        this.outside.post = undefined;
      } else {
        if (!this.env_ssr) {
          getPost(this.id).then((data) => {
            this.title = data.title;
            this.content = data.content;
            this.tags = data.tags;
            document.getElementsByTagName("title")[0].text = data.title
          });
        }
      }

    },

    beforeDestroy() {
      document.getElementsByTagName("title")[0].text = "Peter's Blog"
    },

    mounted() {
      scrollTo(0, 0);
      Prism.highlightAll();

      if (FB) {
        FB.XFBML.parse();
      }
    },

    updated() {
      Prism.highlightAll();
    },
    methods: {
      inited(viewer) {
        self.showViewer = function () {
          viewer.show()
        }
      },
      show() {
        this.$viewer.show()
      },

      scrollToElement(i_node_class) {
        self.scrollToElement(i_node_class, {
          offset: -55
        })
      },

      postrender(str) {
        if (typeof DOMParser !== "undefined") {
          let dom = new DOMParser().parseFromString(str, "text/html");
          let img_tags = Array.from(dom.getElementsByTagName("img"));
          img_tags.forEach((img) => {
            img.setAttribute("v-on:click", "show")
          })
          this.images = img_tags.map((img) => {
            return img.getAttribute("src")
          })

          //this.addContetIndex(dom);
        }
        str = str.replace(/(src)/g, "onclick='showViewer()' $&")

        return str.replace(/(href)/g, "target='_blank' $&")
      },

      addContetIndex() {
        if (!this.env_ssr) {
          setTimeout(() => {
            let arr = Array.from(document.querySelectorAll("h1,h2,h3,h4"));
            console.log(arr);
            window.__arr = arr;
            arr.forEach((n, index) => {
              n.classList.add(`_N_${index}`)
            });
            this.index_nodes = arr;
          })

        }
      }
    },
    components: {
      VueMarkdown,
      'v-icon': Icon,
      Viewer
    }
  }
</script>