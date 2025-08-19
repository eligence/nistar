<template>
  <svg
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns="http://www.w3.org/2000/svg"
    width="576"
    height="1010"
    viewBox="-2 2 288 505"
    class="etz-chaim-svg"
  >
    <!-- Sephiroth Circles -->
    <defs>
      <g id="Sephiroth">
        <circle class="circle-1" cx="142.5" cy="66.3" r="34.2"/>
        <circle class="circle-2" cx="248.7" cy="123.9" r="34.2"/>
        <circle class="circle-3" cx="35.2" cy="124.8" r="34.2"/>
        <circle class="circle-4" cx="36.2" cy="218.4" r="34.2"/>
        <circle class="circle-5" cx="248.7" cy="218.4" r="34.2"/>
        <circle class="circle-6" cx="141.5" cy="257.4" r="34.2"/>
        <circle class="circle-7" cx="35.2" cy="312" r="34.2"/>
        <circle class="circle-8" cx="248.7" cy="312" r="34.2"/>
        <circle class="circle-9" cx="142.5" cy="352" r="34.2"/>
        <circle class="circle-10" cx="142.5" cy="446.6" r="34.2"/>
      </g>
    </defs>

    <!-- Main Sephiroth Structure -->
    <g class="sephiroth-group">
      <use xlink:href="#Sephiroth" class="sephiroth-use"/>
      <circle class="circle-0" cx="141.5" cy="163.8" r="34.2"/>
    </g>
    <!-- Connecting Lines - Right Side -->
    <path class="connecting-line" d="M 162.85 418.275 L 227.2 339.3" id="path1"/>
    <path class="connecting-line" d="M 216.45 324.675 L 175.525 343.2" id="path2"/>
    <path class="connecting-line" d="M 216.45 298.35 L 168.675 275.925" id="path3"/>
    <path class="connecting-line" d="M 216.45 231.075 L 175.5 251.55" id="path4"/>
    <path class="connecting-line" d="M 161.85 229.125 L 227.175 150.15" id="path5"/>

    <!-- Horizontal Connecting Line -->
    <path class="connecting-line" d="M 69.275 124.8 L 214.525 123.825" id="path6"/>

    <!-- Left Side Lines -->
    <path class="connecting-line" d="M 113.15 82.875 L 65.375 109.2" id="path7"/>
    <path class="connecting-line" d="M 57.525 151.125 L 122.85 228.1" id="path8"/>
    <path class="connecting-line" d="M 68.3 232.05 L 107.2 251.55" id="path9"/>
    <path class="connecting-line" d="M 112.125 274.95 L 64.35 294.45" id="path10"/>
    <path class="connecting-line" d="M 69.275 312 L 214.5 312" id="path11"/>
    <path class="connecting-line" d="M 68.3 322.725 L 111.15 340.275" id="path12"/>
    <path class="connecting-line" d="M 56.575 338.325 L 123.825 418.275" id="path13"/>

    <!-- Vertical Lines -->
    <path class="vertical-line" d="M 142.454 100.4 L 142.454 130.3" id="path14"/>
    <path class="vertical-line" d="M 142.454 197.5 L 142.454 223.85" id="path15"/>
    <path class="vertical-line" d="M 142.454 291.5 L 142.454 317.85" id="path16"/>
    <path class="vertical-line" d="M 142.454 386 L 142.454 412" id="path17"/>

    <!-- Decorative Lines -->
    <path class="decorative-line" d="M 218.4 108.225 L 172.575 82.875" id="path18"/>
    <path class="decorative-line" d="M 35.12 158.9 L 35.1 184.275" id="path19"/>
    <path class="decorative-line" d="M 35.158 252.525 L 35.1 277.875" id="path20"/>
    <path class="decorative-line" d="M 248.631 252.525 L 248.625 277.875" id="path21"/>
    <path class="decorative-line" d="M 248.625 157.975 L 248.625 184.275" id="path22"/>
    <path class="decorative-line" d="M 70.225 218.4 L 214.525 218.4" id="path23"/>
    </svg>
</template>

<script setup lang="ts">
const props = defineProps<{
  showLines?: boolean
}>()

const lineDisplay = computed(() => props.showLines ? 'block' : 'none')

</script>
<style scoped>
.etz-chaim-svg {
  display: block;
  max-width: 100%;
  height: auto;
}

.sephiroth-group {
  fill: none;
  stroke: #ffffff;
  stroke-width: 8;
  stroke-linecap: round;
  stroke-linejoin: bevel;
  stroke-miterlimit: 4;
  stroke-dasharray: none;
}

/* Progressive opacity for circles */
/*.circle-0 { stroke-opacity: 0.6; }
.circle-1 { stroke-opacity: 0.9; }
.circle-2 { stroke-opacity: 0.9; }
.circle-3 { stroke-opacity: 0.9; }
.circle-4 { stroke-opacity: 0.9; }
.circle-5 { stroke-opacity: 0.9; }
.circle-6 { stroke-opacity: 0.9; }
.circle-7 { stroke-opacity: 0.9; }
.circle-8 { stroke-opacity: 0.9; }
.circle-9 { stroke-opacity: 0.9; }
.circle-10 { stroke-opacity: 0.6; }*/

.connecting-line,
.vertical-line,
.decorative-line {
  display: v-bind(lineDisplay);
  fill: none;
  fill-rule: evenodd;
  stroke: #ffffff;
  stroke-width: 3;
  stroke-linecap: butt;
  stroke-linejoin: miter;
  stroke-opacity: 1;
  stroke-miterlimit: 4;
  stroke-dasharray: none;
}
</style>
