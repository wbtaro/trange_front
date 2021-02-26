<template>
  <div>
    <div class="container-fluid bg-light">
      <div class="mx-auto py-5 justify-content-center text-center">
        <section>
          <h2 class="display-4 mb-4 font-weight-bold">Trange</h2>
          <p class="mb-2">起点駅から指定した時間内に到着できる駅を検索できるサービスです</p>
          <p class= "mb-5">複数の条件を指定することもできます</p>
          <p class="mb-4 h4">例えばこんなとき</p>
          <ul class="list-unstyled tect-center mb-4">
            <li>会社の最寄り駅に30分以内で行けるジムを探したい...</li>
            <li>みんなの勤め先の中間地点で飲みたい...</li>
            <li>家族の学校や勤務先、全てに1時間以内で行ける場所に引っ越したい...</li>
          </ul>
          <p class="h4">条件を満たすを駅をリストアップできます</p>
        </section>
        <p class="my-5">
          <a href="/search">
            <button class="btn btn-primary btn-lg">検索する</button>
          </a>
        </p>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "Home"
};
</script>
