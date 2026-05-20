{var $ticketsServiceId = $ticketsId ?: 'tv.nzMoskvaServiceId' | resource}

<script class="js-nz-moskva-script" defer src="https://xn--80aaacfpel4cc2n3b.xn--80adxhks/widget.{$ticketsServiceId}.js"></script>
<div class="p_widget_1_{$ticketsServiceId} nz-moskva-widget js-nz-moskva-widget" data-id="{$ticketsServiceId}"></div>
<script>
    let var{$ticketsServiceId} = {$ticketsServiceId};
</script>
