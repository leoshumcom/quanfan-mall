# 使用 GitHub Git Data API 推送代码
# 运行: cd quanfan-mall; powershell -File docs/push-to-github.ps1

$repo = "leoshumcom/quanfan-mall"
$branch = "main"
$baseTree = $null  # 空树

# 获取当前提交的父引用
try {
    $ref = gh api "repos/$repo/git/refs/heads/$branch" | ConvertFrom-Json
    $parentSha = $ref.object.sha
    $commit = gh api "repos/$repo/git/commits/$parentSha" | ConvertFrom-Json
    $baseTree = $commit.tree.sha
    Write-Host "Using existing branch, parent: $parentSha"
} catch {
    Write-Host "Creating new branch from empty"
}

# 递归获取所有文件
$files = Get-ChildItem -Recurse -File | Where-Object {
    $_.FullName -notmatch '\\.git\\' -and
    $_.Name -ne '.git' -and
    $_.FullName -notmatch '\\docs\\push-to-github.ps1$'
}

# 创建 blob 并构建 tree entries
$treeEntries = @()
foreach ($file in $files) {
    $relative = $file.FullName.Substring((Get-Location).Path.Length + 1) -replace '\\', '/'
    $content = [System.IO.File]::ReadAllBytes($file.FullName)
    $base64 = [System.Convert]::ToBase64String($content)
    
    Write-Host "Uploading: $relative"
    
    $blobResult = gh api --method POST "repos/$repo/git/blobs" -f content=$base64 -f encoding="base64" | ConvertFrom-Json
    $sha = $blobResult.sha
    
    $treeEntries += @{
        path = $relative
        mode = "100644"
        type = "blob"
        sha = $sha
    }
}

# 创建 tree
$treeBody = @{
    tree = $treeEntries
    base_tree = $baseTree
} | ConvertTo-Json -Depth 5

$treeResult = gh api --method POST "repos/$repo/git/trees" --input - @($treeBody) | ConvertFrom-Json
$treeSha = $treeResult.sha

# 创建 commit
$commitBody = @{
    message = "feat: init project skeleton (API push)"
    tree = $treeSha
} | ConvertTo-Json

if ($parentSha) {
    $commitBody = @{
        message = "feat: init project skeleton (API push)"
        tree = $treeSha
        parents = @($parentSha)
    } | ConvertTo-Json
}

$commitResult = gh api --method POST "repos/$repo/git/commits" --input - @($commitBody) | ConvertFrom-Json
$commitSha = $commitResult.sha

# Update branch ref
gh api --method PATCH "repos/$repo/git/refs/heads/$branch" -f sha=$commitSha -f force=$true | ConvertFrom-Json

Write-Host "Done! Pushed $($files.Count) files, commit: $commitSha"
Write-Host "https://github.com/$repo"
