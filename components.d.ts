// This file provides TypeScript type definitions for auto-imported components
declare global {
  // Layout components
  const LayoutMain: typeof import('./app/components/layout/Main.vue')['default']
  const LayoutHeader: typeof import('./app/components/layout/Header.vue')['default']
  const LayoutFooter: typeof import('./app/components/layout/Footer.vue')['default']

  // UI components
  const UiCardShow: typeof import('./app/components/ui/ShowCard.vue')['default']
  const UiSocialLinks: typeof import('./app/components/ui/SocialLinks.vue')['default']

  // Animation components
  const AnimationParticleSystem: typeof import('./app/components/animations/ParticleSystem.vue')['default']
  const AnimationSmoke: typeof import('./app/components/animations/Smoke.vue')['default']
  const AnimationSparks: typeof import('./app/components/animations/Sparks.vue')['default']

  // Icon components
  const IconEtzChaim: typeof import('./app/components/icons/EtzChaim.vue')['default']

  // Media components
  const MediaYoutubeEmbed: typeof import('./app/components/media/YouTubeEmbed.vue')['default']

  // Navigation components
  const NavMobileMenu: typeof import('./app/components/navigation/MobileMenu.vue')['default']
  const NavMenuToggle: typeof import('./app/components/navigation/MenuToggle.vue')['default']
}

export {}  // Important for TypeScript module augmentation
