<template lang="pug">
p(:class=" following ? 'log-header__link--unfollow' : 'log-header__link--follow' " @click="push")
  | {{label}}
</template>
<script>
export default {
  props: ["logId"],
  data() {
    return {
      following: false,
      label: "フォローする"
    };
  },
  mounted() {
    fetch(`/api/log_followings.json?log_id=${this.logId}`, {
      method: "GET",
      headers: {
        "X-Requested-With": "XMLHttpRequest",
        "X-CSRF-Token": this.token()
      },
      credentials: "same-origin"
    })
      .then(response => {
        console.log("then");
        return response.json();
      })
      .then(json => {
        if (json) {
          this.following = true;
          this.label = "フォロー解除";
        }
      })
      .catch(error => {
        console.warn("Failed to parsing", error);
      });
  },
  methods: {
    token() {
      const meta = document.querySelector('meta[name="csrf-token"]');
      return meta ? meta.getAttribute("content") : "";
    },
    push() {
      if (this.following) {
        this.unfollow();
      } else {
        this.follow();
      }
    },
    follow() {
      let params = {
        log_id: this.logId
      };
      fetch(`/api/log_followings`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "X-Requested-With": "XMLHttpRequest",
          "X-CSRF-Token": this.token()
        },
        credentials: "same-origin",
        redirect: "manual",
        body: JSON.stringify(params)
      })
        .then(response => {
          return response.json();
        })
        .then(json => {
          this.following = true;
          this.label = "フォロー解除";
        })
        .catch(error => {
          console.warn("Failed to parsing", error);
        });
    },
    unfollow() {
      fetch(`/api/log_followings/${this.logId}.json`, {
        method: "DELETE",
        headers: {
          "X-Requested-With": "XMLHttpRequest",
          "X-CSRF-Token": this.token()
        },
        credentials: "same-origin",
        redirect: "manual"
      })
        .then(response => {
          this.following = false;
          this.label = "フォローする";
        })
        .catch(error => {
          console.warn("Failed to parsing", error);
        });
    }
  }
};
</script>
