# Publishing Guide

The commercial publication set is maintained separately from this public code repository. The canonical project reference is:

**https://github.com/sanskarIN/dart-flutter-master**

## Recommended channels

- Amazon KDP — complete Kindle EPUB; six-volume print editions after separate print proofing.
- Google Play Books — complete EPUB and PDF.
- Apple Books — validated EPUB.
- Kobo Writing Life — EPUB.
- Leanpub — PDF and EPUB for a technical-reader audience and revision workflow.
- Gumroad — direct Reader/Builder/Complete digital bundles.
- Payhip — direct downloadable bundles.
- Own website — central landing page linking to the chosen checkout providers.

## Canonical publication files

- Complete master EPUB for reflowable eBook stores.
- Complete master PDF for fixed-layout/direct digital delivery.
- Six individual volume PDFs for print-oriented workflows.
- Master cover PNG for digital listings.
- Platform-specific full-wrap print covers only after trim size, paper, bleed, and final page counts are fixed.
- Sample PDF for previews/direct marketing.
- Companion source-code ZIP for direct Builder/Complete bundles.

## Release discipline

1. Freeze an edition/version.
2. Run current stable Dart/Flutter validation on companion projects.
3. Validate EPUB with the current store/tool requirements.
4. Run PDF preflight and visually inspect representative pages.
5. Verify title, author, description, categories, identifiers, territories, pricing, tax/bank details, and support contact.
6. Test download/purchase delivery before public launch.
7. Record corrections in `ERRATA.md` and changes in `CHANGELOG.md`.
8. Replace files on existing store listings for revised editions instead of accidentally creating duplicate products.

The complete platform-by-platform upload guide is included with the commercial publication package as `PUBLISHING_PLATFORMS_AND_UPLOAD_GUIDE.md`.
