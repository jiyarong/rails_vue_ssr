<template>
  <div>
    <template v-for="post in posts">
      <div class="post-item">
        <router-link :to="'/posts/' + post.id" >
          <div class="post-item__title">
            <div class="title-area">
              <div class="title">{{post.title}}</div>
              <div class="post-item__tags">
                <template v-for="tag in post.tags">
                  <span>{{tag.name}}</span>
                </template>
              </div>
            </div>

            <div class="edit-area" v-if="$store.state.hasLogin">
              <router-link :to="'/posts/edit/' + post.id" >
                <button style="background: burlywood">
                  <v-icon name="edit"></v-icon>
                </button>
              </router-link>
              <!--<button style="background: crimson">-->
              <!--<v-icon name="trash-alt"></v-icon>-->
              <!--</button>-->
            </div>
          </div>
        </router-link>
        <div class="post-item__updated_at">
          <span>{{post.updated_at}}</span>
        </div>
      </div>
    </template>
  </div>
</template>

<script>
  import "./index.scss";
  import 'vue-awesome/icons/edit'
  import 'vue-awesome/icons/trash-alt'
  import Icon from 'vue-awesome/components/Icon'

  export default {
    props: ['posts'],
    components: {
      'v-icon': Icon
    }
  }
</script>

