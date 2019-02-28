/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import RailsVueUJS from '../rails_vue_ujs';
import VueRouter from 'vue-router';
import Vuex from 'vuex';
import store from "../vue_components/store";
var componentRequireContext = require.context("vue_components", true);
RailsVueUJS.initialComponentsContext(componentRequireContext);
RailsVueUJS.use(VueRouter, Vuex);
RailsVueUJS.initializeVuexStore(store);
self.RailsVueUJS = RailsVueUJS;
