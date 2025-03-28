<!-- Title and Description of the Page -->
<svelte:head>
    <title>Terms & Conditions - Betropolis</title>
    <meta name="description" content="Terms & Conditions of Betropolis Casino." />
</svelte:head>

<script lang="ts">
  import { _ } from "svelte-i18n";
</script>

<main>
  <div class="border m-1 text-white md:w-3/4 lg:w-1/2 mt-5 px-5">
    <h1>{$_("page.terms&conditions.title")}</h1>
    
    <h2>{$_("authTitle")}</h2>
    
    <h3 class="borgens text-xl text-justify">
      We’re thrilled to have you here. Before you dive into the games, please take a moment to go over our terms and conditions. By using our services, you agree to the following:
    </h3>
    
    <h2>1. Eligibility</h2>
    <p>You must be at least 18 years old to use our platform.</p>
    <p>You must accept these conditions and our 
      <a href="/privacy-policy">
        {$_("page.privacy-policy.title")}
      </a>.
    </p>
    
    <h2>2. Account Creation</h2>
    <p>Keep your account information secure. Don’t share your password with others. Provide accurate and up-to-date information when creating your account.</p>
    
    <h2>3. Fair Play</h2>
    <p>We maintain a fair gaming environment, with games that use certified Random Number Generators (RNG). Any attempts to cheat, exploit, or use prohibited software to gain an advantage will lead to account suspension or permanent bans.</p>
    
    <h2>4. Deposits and Withdrawals</h2>
    <p>
      We accept various payment methods, which you can find in our 
      <a href="/hub">Hub</a> 
      under "Manage funds". Withdrawals are subject to verification and may take up to 48 hours for processing.
    </p>
    
    <h2>5. Responsible Gaming</h2>
    <p>
      Gambling should always be fun. If you feel it’s getting out of control, please check 
      <a href="https://en.wikipedia.org/wiki/Responsible_gambling">here</a>
      for resources and support.
    </p>
    
    <h2>6. Closing Your Account</h2>
    <p>You can close your account any time, if you decide to. You can do this easily on your <a href="/profile">Profile Page</a>.</p>
    
    <h2>7. Changes to Terms</h2>
    <p>We reserve the right to modify these Terms at any time. We’ll do our best to notify you, but it’s your responsibility to stay updated.</p>

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