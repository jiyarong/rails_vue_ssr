<template>
  <div>
    <section class="homepage-section">
      <div class="homepage-bg-container">
      </div>
      <h1 class="homepage-title">Welcome to Peter's Blog!</h1>
      <div class="homepage-sentence">
        <template v-for="s in this.display_sentences">
          <label>{{s}}</label>
        </template>
        <div v-show="this.sentence_inputting" class="vertical-line">|</div>
      </div>
    </section>
    <div v-show="this.outside.posts" class="homepage-newest-posts">
      <h2 class="posts-panel-title">
        最新文章
        <router-link class="homepage-more-posts" to="/posts">
          more>
        </router-link>
      </h2>
      <div class="homepage-posts-container">
        <post-list :posts="this.outside.posts.slice(0, 10)"></post-list>
      </div>
    </div>
  </div>
</template>
<script>
  import PostList from './posts/index/list'
  export default {
    props: ['outside'],

    data() {
      return {
        sentence: "千里之行，始于足下",
        display_sentences: [],
        sentence_inputting: true
      }
    },

    beforeDestroy() {
      let navigation_bar = document.getElementsByClassName('navigation-bar')[0]
      navigation_bar.style.backgroundColor = 'cadetblue';
    },

    mounted() {
      let navigation_bar = document.getElementsByClassName('navigation-bar')[0]
      navigation_bar.style.backgroundColor = '#434c9e';

      let i = 0;
      setInterval(() => {
        if (i < this.sentence.length) {
          this.display_sentences.push(this.sentence[i])
          i += 1
        } else {
          this.sentence_inputting = false;
          return false
        }
      }, 400)
    },
    components: {
      'post-list': PostList
    }
  }
</script>

<style>
  .homepage-section {
    text-align: center;
    height: 300px;
    position: relative;
    top: -30px;
    font-style: italic
  }

  .homepage-bg-container {
    position: absolute;
    height: 350px;
    width: 100%;
    z-index: -1;
    animation: bgColorShouldDecrease 3s;
    opacity: .7;
    background-image: url("https://peter-blog-1256175221.cos.ap-chengdu.myqcloud.com/peter-blog-home-banner.jpg");
  }


  .homepage-sentence {
    font-size: 20px;
    color: #FFFFFF;
    display: inline;
  }

  .vertical-line {
    display: inline;
    animation: twinkAsInput 1s infinite;
    animation-iteration-count: 10
  }

  .homepage-newest-posts {
    animation: opacityDuration 1.5s;
  }

  .homepage-title {
    color: #FFFFFF;
    position: relative;
    top: 10px;
    animation: fadeInDown 3s;
    padding-top: 100px;
  }

  .posts-panel-title {
    width: 100%;
    background: #879bde;
    padding: 5px;
    color: antiquewhite;
  }

  .homepage-posts-container {
    text-align: center;
  }

  .homepage-more-posts {
    float: right;
    padding-right: 20px;
    color: antiquewhite;
    font-style: italic;
    text-decoration: none;
  }
  
  @keyframes bgColorShouldDecrease {
    from {
      height: 1000px;
      opacity: 1;
    }

    to {
      height: 350px;
      opacity: .8;
    }
  }

  @keyframes opacityDuration {
    from {
      opacity: .2;
    }

    to {
      opacity: 1;
    }
  }


  @keyframes twinkAsInput {
    from {
      opacity: 1;
    }

    to {
      opacity: .5;
    }
  }

  @keyframes fadeInDown
  {
    from {
      top: -20px;
      opacity: .4;
    }

    to {
      top: 10px;
      opacity: 1;
    }
  }
</style>