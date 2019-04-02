<template>
  <div :class="'menu-items ' + `menu-items-${direction}`">
    <router-link v-if="this.routerLink" :style="'color: ' + this.color" :to="this.routerLink">
      <slot></slot>
    </router-link>

    <a v-else-if="this.href" :href="this.href" :style="'color: ' + this.color">
     <slot></slot>
    </a>

    <div :class="`${this.mId} menu-group-trigger`" v-else-if="this.group" :style="'color: ' + this.color" @click="activeGroupMenu()">
      <slot></slot>
      <v-icon class="sort-arrow" v-if="!this.groupMenuActive" name="sort-down"></v-icon>
      <v-icon class="sort-arrow-up" v-else name="sort-up"></v-icon>
      <div class="menu-groups" v-show="this.groupMenuActive">
        <div class="menu-group" v-for="g in this.group">
          <router-link v-if="g.routerLink" :to="g.routerLink">{{g.name}}</router-link>
          <a v-else :href="g.href">{{g.name}}</a>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import Icon from 'vue-awesome/components/Icon'
  import 'vue-awesome/icons/sort-down'
  import 'vue-awesome/icons/sort-up'

  export default {
    props: {
      routerLink: String,
      href: String,
      group: Array,
      direction: {type: String, default: "left"},
      color: String
    },

    data () {
      return {
        groupMenuActive: false,
        mId: Math.random().toString()
      }
    },

    mounted () {
      if (this.group) {
        document.addEventListener('click', (e) => {
          if (e.target.classList[0] !== this.mId) {
            this.groupMenuActive = false
          }
        })
      }

    },

    methods: {
      activeGroupMenu () {
        this.groupMenuActive = !this.groupMenuActive
      }
    },
    components: {
      'v-icon': Icon
    }
  }
</script>