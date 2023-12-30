# cloudflare

## security considerations

This is safe as a public repository because: 
1. Only I can see GitHub Actions [secrets](https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions)
2. Only those who have write access to the HEAD branch (main) can make pull [requests](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request) (currently none)
3. Workflows are currently not run from pull requests from public [forks](https://docs.github.com/en/actions/managing-workflow-runs/approving-workflow-runs-from-public-forks) (approval is needed for each pull request from a public fork)

Additionally, the secret API key used only gives minimal permissions to Cloudflare. An account takeover would not be possible even if it is leaked.