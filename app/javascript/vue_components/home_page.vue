<template>
  <div class="homepage-container">
    <div class="fixed-home-title">
      <section class="homepage-section">
        <div class="homepage-diary">
          <div v-show="!this.switchingDiary" class="homepage-diary-content" v-html="currentDiary.content"></div>
        </div>

        <div class="homepage-diary-created-at">
          {{currentDiary.created_at}}
        </div>

        <div v-show="hasPrevDiary"  class="homepage-prev-diary" @click="viewPrevDiary">
          <v-icon name="angle-double-left" scale="2"></v-icon>
        </div>

        <div v-show="hasNextDiary" class="homepage-next-diary" @click="viewNextDiary">
          <v-icon name="angle-double-right" scale="2"></v-icon>
        </div>

        <div class="homepage-down-arrow" @click="scrollToNext">
          <v-icon name="angle-double-down" scale="2"></v-icon>
        </div>

      </section>
    </div>

    <div class="relative-home-content">
      <div v-show="this.outside.posts" class="homepage-newest-posts">
        <div class="posts-panel-title">
          最新文章
          <router-link class="homepage-more-posts" to="/posts">
            more>
          </router-link>
        </div>
        <div class="homepage-posts-container">
          <post-list :posts="this.outside.posts.slice(0, 10)"></post-list>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
  import PostList from './posts/index/list';
  import 'vue-awesome/icons/angle-double-down';
  import 'vue-awesome/icons/angle-double-left';
  import 'vue-awesome/icons/angle-double-right';
  import Icon from 'vue-awesome/components/Icon';
  import { prevDiary, nextDiary } from '../src/api';
  export default {
    props: ['outside'],

    data() {
      return {
        currentDiary: (this.outside && this.outside.diary) || {},
        nextDiary: null,
        prevDiary: null,
        hasPrevDiary: true,
        hasNextDiary: false,
        switchingDiary: false
      }
    },

    beforeDestroy() {
      let navigation_bar = document.getElementsByClassName('navigation-bar')[0]
      navigation_bar.style.backgroundColor = 'cadetblue';
    },

    mounted() {
      let navigation_bar = document.getElementsByClassName('navigation-bar')[0]
      navigation_bar.style.backgroundColor = 'rgba(0,0,0,.6)';
    },

    methods: {
      viewPrevDiary () {
        this.switchingDiary = true;
        this.nextDiary = this.currentDiary;
        this.hasNextDiary = true;
        prevDiary(this.currentDiary.id).then((data) => {
          if (data.diary !== null) {
            this.currentDiary = data.diary
          }
          this.hasPrevDiary = !data.is_latest
        });
        this.prevDiary = null;
        setTimeout(() => {
          this.switchingDiary = false
        })
      },

      viewNextDiary () {
        this.switchingDiary = true;
        this.prevDiary = this.currentDiary;
        this.hasPrevDiary = true;
        nextDiary(this.currentDiary.id).then((data) => {
          if (data.diary !== null) {
            this.currentDiary = data.diary;
          }
          this.hasNextDiary = !data.is_latest
        });
        this.nextDiary = null;
        setTimeout(() => {
          this.switchingDiary = false
        })
      },

      scrollToNext () {
        scrollToElement('.homepage-newest-posts', {
          offset: -50,
          duration: 1500
        });
      }
    },

    components: {
      'post-list': PostList,
      'v-icon': Icon
    }
  }
</script>

<style>
  .homepage-container {
    position: relative;
    width: 100%;
  }

  .fixed-home-title {
    position: fixed;
    width: 100vw;
    height: 100vh;
    z-index: 1;
  }

  .relative-home-content {
    z-index: 100;
    position:relative;
    top: 100vh;
    background: beige;
    min-height: 100vh;
  }

  @keyframes transformXY {
    from {
      transform: scaleX(1.1) scaleY(1.1);
      filter:blur(0);
    }

    to {
      transform: scaleX(1.2) scaleY(1.2);
      filter:blur(3px);
    }
  }

  .homepage-down-arrow {
    color: #FFFFFF;
    text-align: center;
    position: absolute;
    bottom: 12%;
    width: 100%;
    opacity: .4;
    transition: opacity .2s ease-in;
    animation: twink 3s infinite;
  }

  .homepage-down-arrow:hover,
  .homepage-prev-diary:hover,
  .homepage-next-diary:hover {
    opacity: 1;
    animation: none;
  }

  .homepage-prev-diary {
    color: #FFFFFF;
    text-align: center;
    position: absolute;
    bottom: 50%;
    left: 5%;
    opacity: .4;
    transition: opacity .2s ease-in;
  }

  .homepage-next-diary {
    color: #FFFFFF;
    text-align: center;
    position: absolute;
    bottom: 50%;
    right: 5%;
    opacity: .4;
    transition: opacity .2s ease-in;
  }

  .homepage-section::before{
    content:'';
    position:absolute;
    top:0;
    left:0;
    width:100%;
    height:94vh;
    background:transparent url(https://peter-blog-1256175221.cos.ap-chengdu.myqcloud.com/peter-blog-home-banner.jpg) center center no-repeat;
    filter:blur(3px);
    z-index:-1;
    background-size:cover;
    animation: transformXY 1.5s ease-in;
    transform: scaleX(1.2) scaleY(1.2);

  }

  .homepage-section {
    background: rgba(0, 0, 0, 0.5);
    /*text-align: center;*/
    height: 100vh;
    position: relative;
    width: 100%;
    /*top: -30px;*/
    font-style: italic;
    /*background-image: url("https://peter-blog-1256175221.cos.ap-chengdu.myqcloud.com/peter-blog-home-banner.jpg");*/

  }

  .homepage-bg-container {
    /**/
    position: absolute;
    height: 350px;
    width: 100%;
    z-index: -1;
    /*animation: bgColorShouldDecrease 3s;*/
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
    /*animation: opacityDuration 1.5s;*/
  }

  .homepage-title {
    color: #FFFFFF;
    position: relative;
    top: 10px;
    animation: fadeInDown 1.5s;
  }

  .homepage-diary {
    font-size: 18px;
    color: #FFFFFF;
    animation: fadeInDown 1.5s;
    position: relative;
    top: 10px;
    padding-top: 5%;
  }

  .homepage-diary-content {
    margin-left: auto;
    margin-right: auto;
    width: 45%;
    animation: fadeInDown 1.5s;
  }


  .homepage-diary-created-at {
    display: block;
    position: absolute;
    right: 10%;
    bottom: 15%;
    color: #FFFFFF;
  }

  .posts-panel-title {
    width: 100%;
    background: #000000;
    padding: 10px;
    color: antiquewhite;
    font-size: 20px;
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
    transition: color .1s ease-in;
  }

  .homepage-more-posts:hover {
    color: #ff9200;
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


  @keyframes twink {
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

  @media only screen
  and (min-device-width: 300px)
  and (max-device-width: 500px) {
    .homepage-section::before {
      animation: none;
      transform: none;
      height: 100vh;
    }

    .homepage-section {
      /*height: 500px;*/
    }

    .posts-panel-title {
      padding: 0;
    }
  }
</style>