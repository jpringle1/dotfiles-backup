Generate new SSH key in .dotfiles/ssh:
`ssh-keygen -t ed25519 -C "joe.pringle@proton.me"`

Paste entire key (whole line) into new ssh key box in github settings.
`cat ~/.ssh/id_ed25519.pub`

Convert HTTP repo to SSH repo:
`git remote set-url origin git@github.com:jpringle1/repo.git`
