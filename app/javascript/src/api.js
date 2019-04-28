import store from '../vue_components/store';

const getCsrfToken = () => {
  return store.state.csrfToken
};

const getHeader = (method="GET", body=null) => {
  let h = {
    credentials: "include",
    method: method,
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'X-CSRF-Token': getCsrfToken()
    },
  };
  if (["PUT", "POST"].includes(method)) {
    h.body = JSON.stringify(body)
  }
  return h
};

class Requester {
  constructor (header, url) {
    this.header = header;
    this.url = url;
  }

  do_fetch () {
    return new Promise((resolve, reject) => {
      let timeout = setTimeout(() => {
        reject("请求超时")
      }, 20000);
      fetch(this.url, this.header).then((response) => {
        clearTimeout(timeout);
        if (response.ok) {
          return response.json()
        } else {
          return reject(response)
        }
      }).then((responseData) => {
        return resolve(responseData)
      }).catch((err) => {
        return reject(err)
      })
    })
  }
}

export const getPosts = (page) => {
  return new Requester(getHeader(), `/api/posts?page=${page}`).do_fetch()
};

export const getPost = (id) => {
  return new Requester(getHeader(), `/api/posts/${id}`).do_fetch()
};

export const createPost = (attributes) => {
  return new Requester(getHeader("POST", attributes), '/api/posts').do_fetch()
};

export const updatePost = (id, attributes) => {
  return new Requester(getHeader("PUT", attributes), `/api/posts/${id}`).do_fetch()
};

export const createDiary = (attributes) => {
  return new Requester(getHeader("POST", attributes), '/api/diaries').do_fetch()
}