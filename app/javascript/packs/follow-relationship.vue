<template lang="pug">
p(:class=" following ? 'user-profile-links__link--unfollow' : 'user-profile-links__link--follow' " @click="push")
  | {{label}}
</template>
<script>
export default {
  props: ["currentUserId", "userId"],
  data() {
    return {
      following: false,
      label: "フォローする"
    };
  },
  mounted() {
    fetch(`/api/follow_relationships.json?user_id=${this.userId}`, {
      method: "GET",
      headers: {
        "X-Requested-With": "XMLHttpRequest",
        "X-CSRF-Token": this.token()
      },
      credentials: "same-origin"
    })
      .then(response => {
        return response.json();
      })
      .then(json => {
        if (json[0]) {
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
        user_id: this.userId
      };
      fetch(`/api/follow_relationships`, {
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
      this.following = false;
      fetch(`/api/follow_relationships/${this.userId}.json`, {
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
          this.label = "フォロー";
        })
        .catch(error => {
          console.warn("Failed to parsing", error);
        });
    }
  }
};
</script>
