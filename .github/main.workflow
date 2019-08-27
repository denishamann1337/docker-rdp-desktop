workflow "build" {
  on = "push"
  resolves = ["docker"]
}

action "docker" {
  uses = "docker://"
  args = "build ."
}
