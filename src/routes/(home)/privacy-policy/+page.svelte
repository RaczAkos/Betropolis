<svelte:head>
    <title>Privacy Policy - Betropolis</title>
    <meta name="description" content="The Privacy Policy of Betropolis Casino." />
</svelte:head>

<script lang="ts">
  import { _ } from "svelte-i18n";
</script>

<main>

  <div class="border m-1 text-white md:w-3/4 lg:w-1/2 mt-5 px-5">
    <h1>
      {$_("page.privacy-policy.title")}
    </h1>
    
    <h2>Introduction</h2>
    
    <h3 class="text-xl text-justify">Your privacy is essential to us at Betropolis. Here’s a breakdown of how we handle your personal information.</h3>
      
    <h2>1. Information We Collect</h2>
    <p>Account Information: Personal information, contact details when you sign up.</p> 
    <p>Financial Information: Deposit and withdrawal details, securely processed through our trusted payment partners.</p>
      
    <h2>2. Why We Collect Your Information</h2>
    <p>To process payments and manage your account. To prevent fraud and ensure fair gaming practices.</p>
    
    <h2>3. Data Protection</h2>
    <p>
      We use advanced methods and secure storage to protect your data. Access to personal data is restricted to authorized personnel only.
    </p>
    
    <h2>
      4. Third-Party Sharing
    </h2>
    <p>
      We do not sell or share your data with third parties, except as required by law or with trusted partners who help us run our services (e.g., payment processors).
    </p>
    
    <h2>5. Cookies</h2>
    <p>We use cookies to remember your preferences and improve our site’s performance. You can manage cookies in your browser settings.</p>
    
    <h2>6. Your Rights</h2>
    <p>You have the right to access, update, or delete your personal information at any time. Visit your <a href="/profile">Profile Page</a> to exercise these rights.
    </p>
    
    <h2>7. Changes to Our Policy</h2>
    <p>We may update this Privacy Policy as necessary. Significant changes will be posted on our site, so please check back regularly.</p>
    
    <h2>{$_("contact.information")}</h2>
    <p>{$_("contact.dev1")}: szabo.tamas-2020@keri.mako.hu</p>
    <p>{$_("contact.dev2")}: racz.akoscsaba-2020@keri.mako.hu</p>
  </div>
</main>

<style>
  @reference "$lib/app.css";

  main { @apply flex justify-center select-text w-full text-wrap; }

  h1 { @apply text-5xl p-3 border-b text-center mb-2; }

  h2{ @apply border-b italic text-2xl mt-5; }

  h1, h2, h3 { font-family: "Borgens Burlesque"; }

  p { @apply text-justify mb-3 mt-1; }

  a { @apply hover:underline max-sm:underline italic; }
</style>