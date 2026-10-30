# Public Goods Application Toolkit

An open toolkit for writing grant applications that a reviewer can actually verify — built from a
full retrospective of every proposal one public grant programme received over two years.

在线版（无需登录）：<https://ze3250517038-star.github.io/public-goods-application-toolkit/checklist.html>

## 为什么有这个东西

Conflux Integration Grants 两年收到 **36 份提案，只批了 4 份**（约 11%）；14 份挂着没有任何结论，
最老的一份从 2024-08 挂到 2026-09。更关键的是，被拒的绝大多数只收到一句
`did not pass the grant committee's decision` —— **标准从来没被写下来，所以没人能从中学会**。

这个仓库把那套标准写下来。

## 里面有什么

| 文件 | 是什么 |
| --- | --- |
| [`checklist.html`](checklist.html) | 40 项校验清单，单文件、零外链，可直接在浏览器打开或打印 |
| [`checklist.md`](checklist.md) | 清单的纯文本源文件（便于 diff 和 fork） |
| [`grant-application-template.md`](grant-application-template.md) | 过审模板「6 块」：问题→生态因果链 / 里程碑 / 预算 / 专属 KPI / 可验证交付物 / 团队合规 |
| [`checklist.pdf`](checklist.pdf) | 2 页 A4 打印版，可直接发给评审 |
| [`.github/ISSUE_TEMPLATE/application.md`](.github/ISSUE_TEMPLATE/application.md) | 把「我要申请」变成一张结构化任务单，逐条勾完再动笔 |

需要 2 页 A4 的 PDF 时直接用 [`checklist.pdf`](checklist.pdf)；想反馈或要新版，在
[Issues](https://github.com/ze3250517038-star/public-goods-application-toolkit/issues) 里留一句。
改了清单内容要重建 PDF，跑 `tools/make-pdf.ps1`（headless Chrome，固定输出 2 页 A4）。

## 怎么用

1. 打开 `checklist.html`，从第 1 条往下勾。每条都有「判定方式」——不是「写得好不好」，而是「怎么算通过」。
2. 勾不过的项，对着 `grant-application-template.md` 对应那一块补。
3. 全过之后再提交。清单末尾有「提交前 6 步」。

## 许可

- 文档与清单：**CC BY 4.0**（全文见仓库根目录 `LICENSE`）
- 脚本（`tools/`、`*.ps1`、`*.py`）：**MIT**

引用时请写 `Public Goods Application Toolkit`（作者 Lin Jiaze）并链回本仓库。按 CC BY 4.0，署名是条件，不是可选项。

## 版本

- v1.0 — 2026-10
