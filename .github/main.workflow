workflow "build" {
  on = "push"
  resolves = [
    "GitHub Action for Docker-1",
    "gradle",
  ]
}

action "GitHub Action for Docker" {
  uses = "actions/docker/cli@fe7ed3ce992160973df86480b83a2f8ed581cd50"
  args = "build ."
}

action "GitHub Action for Docker-1" {
  uses = "actions/docker/cli@fe7ed3ce992160973df86480b83a2f8ed581cd50"
  needs = ["GitHub Action for Docker"]
  runs = "push"
}

action "gradle" {
  uses = "gradle"
  args = "--version"
}
