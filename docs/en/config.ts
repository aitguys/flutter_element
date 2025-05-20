import { DefaultTheme } from 'vitepress'

export const enConfig = {
  title: 'Flutter Element UI',
  description: 'A Flutter UI component library based on Element Plus design system',
  themeConfig: {
    // Navigation bar configuration
    nav: [
      { text: 'Home', link: '/en/' },
      { text: 'Components', link: '/en/components/' },
      { text: 'Guide', link: '/en/guide/' },
    ],
    // Sidebar configuration
    sidebar: {
      '/en/components/': [
        {
          text: 'Basic Components',
          items: [
            { text: 'Button', link: '/en/components/button' },
            { text: 'Input', link: '/en/components/input' },
            { text: 'Select', link: '/en/components/select' },
            { text: 'Radio', link: '/en/components/radio' },
            { text: 'Checkbox', link: '/en/components/checkbox' },
            { text: 'Switch', link: '/en/components/switch' },
            { text: 'Slider', link: '/en/components/slider' },
            { text: 'Rate', link: '/en/components/rate' },
          ]
        },
        {
          text: 'Data Display',
          items: [
            { text: 'Tag', link: '/en/components/tag' },
            { text: 'Progress', link: '/en/components/progress' },
            { text: 'Table', link: '/en/components/table' },
            { text: 'Pagination', link: '/en/components/pagination' },
            { text: 'Timeline', link: '/en/components/timeline' },
            { text: 'Tree', link: '/en/components/tree' },
          ]
        },
        {
          text: 'Feedback Components',
          items: [
            { text: 'Dialog', link: '/en/components/dialog' },
            { text: 'Message', link: '/en/components/message' },
            { text: 'Notification', link: '/en/components/notification' },
            { text: 'Loading', link: '/en/components/loading' },
            { text: 'Alert', link: '/en/components/alert' },
          ]
        },
        {
          text: 'Navigation Components',
          items: [
            { text: 'Menu', link: '/en/components/menu' },
            { text: 'Tabs', link: '/en/components/tabs' },
            { text: 'Breadcrumb', link: '/en/components/breadcrumb' },
            { text: 'Steps', link: '/en/components/steps' },
            { text: 'Dropdown', link: '/en/components/dropdown' },
          ]
        },
        {
          text: 'Other Components',
          items: [
            { text: 'Calendar', link: '/en/components/calendar' },
            { text: 'DatePicker', link: '/en/components/date-picker' },
            { text: 'TimePicker', link: '/en/components/time-picker' },
            { text: 'Upload', link: '/en/components/upload' },
            { text: 'Form', link: '/en/components/form' },
          ]
        }
      ],
      '/en/guide/': [
        {
          text: 'Guide',
          items: [
            { text: 'Introduction', link: '/en/guide/introduction' },
            { text: 'Quick Start', link: '/en/guide/quickstart' },
            { text: 'Installation', link: '/en/guide/installation' },
            { text: 'Theme Customization', link: '/en/guide/theme' },
          ]
        }
      ]
    },
    // Social links
    socialLinks: [
      { icon: 'github', link: 'https://github.com/yourusername/flutter_element' }
    ],
    // Footer configuration
    footer: {
      message: 'Released under the MIT License',
      copyright: 'Copyright © 2024-present Flutter Element UI'
    },
    // Search configuration
    search: {
      provider: 'local',
      options: {
        translations: {
          button: {
            buttonText: 'Search Documentation',
            buttonAriaLabel: 'Search Documentation'
          },
          modal: {
            noResultsText: 'No results found',
            resetButtonTitle: 'Clear search query',
            footer: {
              selectText: 'select',
              navigateText: 'navigate',
              closeText: 'close'
            }
          }
        }
      }
    }
  }
} as DefaultTheme.Config 