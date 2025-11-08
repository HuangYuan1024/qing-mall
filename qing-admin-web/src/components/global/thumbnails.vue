<template>
        <div class="bighover_imgbox">
            <div :style="'background:url('+ thumbnailImg +') no-repeat center/cover;'" class="table_img" @mouseenter="enter(thumbnailId)" @mouseleave="leave()">
            </div>
            <div class="bighover_img" v-show="thumbnailId==bigimgIndex&&bigimgShow==true?true:false">
                <img :src="thumbnailImg">
            </div>
        </div>        


</template>


<script src="@/api/js/thumbnails.js"></script>