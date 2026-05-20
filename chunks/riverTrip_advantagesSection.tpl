<div class="included-options-section">
    
    <div class="included-options-wrapper">
        
        <div class="included-options-grid">
            <h2 class="subsection-title">Что включено</h2>
            [[getChunkCollection?
                &tpl=`riverTrip.advantageItem`
                &valuesJson=[[+advantagesJson]]
            ]]
        </div>
        [[If?
           &subject=`[[+deficienciesSection]]`
           &operator=`EQ`
           &operand=`1`
           &then=`[[$deficiencies]]`
           &else=``
        ]]
    </div>
</div>