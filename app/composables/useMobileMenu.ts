export function useMobileMenu() {
    return {
        isMobileMenuOpen: useState('isMobileMenuOpen', () => false)
    }
}
