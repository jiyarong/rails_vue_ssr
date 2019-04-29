<template>
  <div class="navigation-bar">
    <slot></slot>
  </div>
</template>

<script>
  export default {

  }
</script>

<style>
  .navigation-bar {
    position: fixed;
    height: 55px;
    width: 100vw;
    background: cadetblue;
    top: 0;
    z-index: 10000;
    padding-left: 20px;
    padding-right: 20px;
  }

  .menu-items {
    /*padding: 5px;*/
    display: inline-block;
    font-size: 22px;
    line-height: 55px;
    padding-right: 20px;
    cursor: default;
  }

  .menu-items:hover a {
    color: #ff9200 !important;
  }

  .menu-items a {
    text-decoration: none;
    transition: color .1s ease-in;
  }

  .menu-items-left {
    float: left;
  }
  .menu-items-right {
    float: right;
  }

  .menu-groups {
    background: floralwhite;
    font-size: 16px;
    /*padding: 10px;*/
    line-height: 25px;
    border-radius: 3px;
    border: 1px solid lightgrey;
    position: absolute;
    width: auto;
    box-shadow: #CCCCCC;
    min-width: 100px;
  }

  .menu-group-trigger:hover {
    background: darkslategray;
  }

  .menu-group {
    border-bottom: 1px solid #DADADA;
    padding: 3px 10px;
  }

  .menu-group:hover {
    background: #0366d6;
  }

  .menu-group a{
    color: lightsalmon;
  }

  .menu-group:hover a {
    color: white
  }

  .sort-arrow-up {
    position: relative;
    top: 4px;
  }
</style>