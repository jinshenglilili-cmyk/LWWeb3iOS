# LWWeb3iOS 🚀

一个基于 SwiftUI 开发的 iOS 加密货币行情应用，支持实时数据查看与投资组合管理。

## ✨ 功能特性

- **📈 实时行情** - 获取最新加密货币价格数据
- **🔍 搜索功能** - 快速搜索加密货币
- **💼 投资组合** - 自定义管理您的加密货币持仓
- **🎨 深色主题** - 专为深色模式设计的优美 UI
- **🔄 排序功能** - 支持按排名、持仓、价格多种方式排序
- **📊 市场统计** - 查看整体市场数据（总市值、24h成交量、BTC Dominance）
- **💾 本地存储** - 投资组合数据持久化存储

## 🏗️ 项目架构

```
LWWeb3iOS/
├── newP/
│   ├── newPApp.swift          # 应用入口
│   ├── ContentView.swift
│   ├── Model/
│   │   ├── CoinModel.swift    # 加密货币数据模型
│   │   ├── MarketDataModel.swift  # 市场数据模型
│   │   └── StatisticModel.swift   # 统计数据模型
│   ├── Services/             # 数据服务层
│   │   ├── CoinDataService.swift      # 加密货币数据服务
│   │   ├── CoinImageService.swift     # 图片加载服务
│   │   ├── PortfolioDataService.swift # 投资组合数据服务
│   │   └── MarketDataService.swift   # 市场数据服务
│   ├── Utility/              # 工具类
│   │   ├── LoacalFilemanager.swift
│   │   └── NetworkingManager.swift
│   └── Core/
│       ├── extension/        # Swift 扩展
│       ├── TabBar/           # 主标签栏
│       ├── Component/         # 通用组件
│       ├── Home/             # 首页模块
│       │   ├── View/
│       │   └── ViewModel/
│       └── Profile/          # 个人资料模块
└── newPTests/                # 单元测试
```

## 🛠 技术栈

- **SwiftUI** - 声明式 UI 框架
- **Combine** - 响应式编程框架
- **Core Data** - 本地数据持久化
- **REST API** - 获取实时加密货币数据

## 📋 环境要求

- iOS 15.0+
- Xcode 14.0+
- Swift 5.7+

## 🚀 快速开始

1. **克隆项目**
```bash
git clone https://github.com/yourusername/LWWeb3iOS.git
cd LWWeb3iOS
```

2. **打开项目**
```bash
open newP.xcodeproj
```

3. **配置 API（可选）**

项目当前使用公开的 CoinGecko API，无需额外配置即可运行。如需更换 API 源，请修改 `CoinDataService.swift` 中的 API URL。

4. **运行项目**

在 Xcode 中选择模拟器或连接真机，点击运行 ▶️

## 🎯 主要模块说明

### 🏠 首页 (`HomeView`)
- 显示所有加密货币列表
- 支持搜索过滤
- 切换查看全部币种 / 投资组合
- 添加加密货币到投资组合

### 💼 投资组合 (`PortfolioView`)
- 显示自定义持仓
- 计算持仓总价值
- 支持编辑持仓数量
- 数据自动保存到本地

### 📊 数据统计
- 全球市场总市值
- 24 小时成交量
- BTC 占比
- 投资组合收益率

## 🎨 设计特色

- 遵循 SwiftUI 设计规范
- 响应式布局适配不同屏幕尺寸
- 自定义主题色彩系统
- 流畅的动画效果
- MVVM 架构设计

## 📝 待办功能

- [ ] 添加币种详情页面
- [ ] 价格图表展示
- [ ] 价格提醒功能
- [ ] 多币种支持
- [ ] 更多筛选条件

## 👨‍💻 作者

Liwei

## 📄 许可证

MIT License - 详见 [LICENSE](LICENSE) 文件

## 🙏 致谢

灵感来源于 Swiftful Thinking 教程，感谢开源社区。

---

⭐️ 如果这个项目对您有帮助，欢迎给一颗星！
