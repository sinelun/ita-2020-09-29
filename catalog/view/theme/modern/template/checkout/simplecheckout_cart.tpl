<div class="simplecheckout-block" id="simplecheckout_cart" <?php echo $hide ? 'data-hide="true"' : '' ?> <?php echo $display_error && $has_error ? 'data-error="true"' : '' ?>>
<?php if ($display_header) { ?>
    <div class="checkout-heading panel-heading"><?php echo $text_cart ?></div>
<?php } ?>
<?php if ($attention) { ?>
    <div class="simplecheckout-warning-block"><?php echo $attention; ?></div>
<?php } ?>
<?php if ($error_warning) { ?>
    <div class="simplecheckout-warning-block"><?php echo $error_warning; ?></div>
<?php } ?>
    <div class="table-responsive">
        <table class="simplecheckout-cart">
            <colgroup>
                <col class="image">
                <col class="name">
                <col class="model">
                <col class="quantity">
                <col class="price">
                <col class="total">
                <col class="remove">
            </colgroup>
            <thead>
                <tr>
                    <th class="image"><?php echo $column_image; ?></th>
                    <th class="name"><?php echo $column_name; ?></th>
                    <th class="model"><?php echo $column_model; ?></th>
                    <th class="quantity"><?php echo $column_quantity; ?></th>
                    <th class="price"><?php echo $column_price; ?></th>
                    <th class="total"><?php echo $column_total; ?></th>
                    <th class="remove"></th>
                </tr>
            </thead>
            <tbody>
            <?php foreach ($products as $product) { ?>
                <?php if (!empty($product['recurring'])) { ?>
                    <tr>
                        <td class="simplecheckout-recurring-product" style="border:none;"><img src="<?php echo $additional_path ?>catalog/view/theme/default/image/reorder.png" alt="" title="" style="float:left;" />
                            <span style="float:left;line-height:18px; margin-left:10px;">
                            <strong><?php echo $text_recurring_item ?></strong>
                            <?php echo $product['profile_description'] ?>
                            </span>
                        </td>
                    </tr>
                <?php } ?>
                <tr>
                    <td class="image">
                        <?php if ($product['thumb']) { ?>
                            <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
                        <?php } ?>
                    </td>
                    <td class="name">
                        <?php if ($product['thumb']) { ?>
                            <div class="image">
                                <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
                            </div>
                        <?php } ?>
                        <a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                        <?php if (!$product['stock'] && ($config_stock_warning || !$config_stock_checkout)) { ?>
                            <span class="product-warning">***</span>
                        <?php } ?>
                        <div class="options">
                        <?php foreach ($product['option'] as $option) { ?>
                        &nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small><br />
                        <?php } ?>
                        <?php if (!empty($product['recurring'])) { ?>
                        - <small><?php echo $text_payment_profile ?>: <?php echo $product['profile_name'] ?></small>
                        <?php } ?>
                        </div>
                        <?php if ($product['reward']) { ?>
                        <small><?php echo $product['reward']; ?></small>
                        <?php } ?>
                    </td>
                    <td class="model"><?php echo $product['model']; ?></td>
                    <td class="quantity">
                        <div class="input-group btn-block" style="max-width: 200px;">
                            <span class="input-group-btn">
                                <button class="btn btn-primary" data-onclick="decreaseProductQuantity" data-toggle="tooltip" type="submit">
                                    <i class="fa fa-minus"></i>
                                </button>
                            </span>
                            <input class="form-control" type="text" data-onchange="changeProductQuantity" name="quantity[<?php echo !empty($product['cart_id']) ? $product['cart_id'] : $product['key']; ?>]" value="<?php echo $product['quantity']; ?>" size="1" />
                            <span class="input-group-btn">
                                <button class="btn btn-primary" data-onclick="increaseProductQuantity" data-toggle="tooltip" type="submit">
                                    <i class="fa fa-plus"></i>
                                </button>
                                <button class="btn btn-danger" data-onclick="removeProduct" data-product-key="<?php echo !empty($product['cart_id']) ? $product['cart_id'] : $product['key'] ?>" data-toggle="tooltip" type="button">
                                    <i class="fa fa-times-circle"></i>
                                </button>
                            </span>
                        </div>
                    </td>
<?php /* -- Task 2020-09-29/2 by sinelun@gmail.com
           2. Если есть акционный товар в корзине или применяется купон или и то и то:
              2.1. Цена должна быть перечеркнутой в колонке цена.
              2.2. Ниже должно быть написано, что применилось "купон" или "акция".
--  */ ?>
<?php if (false) { // commented original ?>
                    <td class="price"><?php echo $product['price']; ?></td>
<?php } ?>
                    <td class="price">
                        <?php if ($product['has_action']) { ?>
                            <span style="color: #CF395B; text-decoration: line-through;">
                                <?php echo $product['price']; ?>
                            </span><br>
                            <span style="color: #0380A1; padding-right: 1em">акция</span>
                        <?php } elseif ($product['coupon_discount']) { ?>
                            <span style="color: #CF395B; text-decoration: line-through;">
                                <?php echo $product['price']; ?>
                            </span><br>
                        <span style="color: #0380A1; padding-right: 1em">купон</span>
                        <?php } else { ?>
                                <?php echo $product['price']; ?>
                        <?php } ?>
                    </td>
<?php /* -- / sinelun@gmail.com --  */ ?>
                    <td class="total"><?php echo $product['total']; ?></td>
                    <td class="remove">
                    </td>
                    </tr>
                    <?php } ?>
                    <?php foreach ($vouchers as $voucher_info) { ?>
                        <tr>
                            <td class="image"></td>
                            <td class="name"><?php echo $voucher_info['description']; ?></td>
                            <td class="model"></td>
                            <td class="quantity">1</td>
                            <td class="price"><?php echo $voucher_info['amount']; ?></td>
                            <td class="total"><?php echo $voucher_info['amount']; ?></td>
                            <td class="remove">
                                <i data-onclick="removeGift" data-gift-key="<?php echo $voucher_info['key']; ?>" title="<?php echo $button_remove; ?>" class="fa fa-times-circle"></i>
                            </td>
                        </tr>
                    <?php } ?>
            </tbody>
        </table>
    </div>

<?php /* -- Task 2020-09-29/4 by sinelun@gmail.com
           4. Поле для ввода купона должно идти после товаров.
--  */ ?>

<?php if (isset($modules['coupon'])) { ?>
<div class="simplecheckout-cart-total">
    <span class="inputs"><?php echo $entry_coupon; ?>&nbsp;<input class="form-control" type="text" data-onchange="reloadAll" name="coupon" value="<?php echo $coupon; ?>" /></span>
</div>
<?php } ?>
<?php if (isset($modules['reward']) && $points > 0) { ?>
<div class="simplecheckout-cart-total">
    <span class="inputs"><?php echo $entry_reward; ?>&nbsp;<input class="form-control" type="text" name="reward" data-onchange="reloadAll" value="<?php echo $reward; ?>" /></span>
</div>
<?php } ?>
<?php if (isset($modules['voucher'])) { ?>
<div class="simplecheckout-cart-total">
    <span class="inputs"><?php echo $entry_voucher; ?>&nbsp;<input class="form-control" type="text" name="voucher" data-onchange="reloadAll" value="<?php echo $voucher; ?>" /></span>
</div>
<?php } ?>
<?php foreach ($totals as $total) { ?>
<div class="simplecheckout-cart-total" id="total_<?php echo $total['code']; ?>">
<?php /* -- Task 2020-09-29/9,12 by sinelun@gmail.com
           9. Фраза "Купон применяется к товару без акции" должна появляться, когда применен купон.
           12. Фраза "Оплата по ремонту осуществляется после оказания услуги", чтобы появлялась слева от нижнего "Итого", если в корзине есть товарные услуги по ремонту.
--  */ ?>
    <span style="color: #CF395B"><b><?php echo $total['pre_title']; ?></b></span>
<?php /* -- /(9,12) sinelun@gmail.com --  */ ?>
    <span><b><?php echo $total['title']; ?>:</b></span>
    <span class="simplecheckout-cart-total-value"><?php echo $total['text']; ?></span>
    <span class="simplecheckout-cart-total-remove">
            <?php if ($total['code'] == 'coupon') { ?>
        <i data-onclick="removeCoupon" title="<?php echo $button_remove; ?>" class="fa fa-times-circle"></i>
        <?php } ?>
        <?php if ($total['code'] == 'voucher') { ?>
        <i data-onclick="removeVoucher" title="<?php echo $button_remove; ?>" class="fa fa-times-circle"></i>
        <?php } ?>
        <?php if ($total['code'] == 'reward') { ?>
        <i data-onclick="removeReward" title="<?php echo $button_remove; ?>" class="fa fa-times-circle"></i>
        <?php } ?>
        </span>
</div>
<?php } ?>

<?php /* -- /(4) sinelun@gmail.com --  */ ?>


<?php /* -- Task 2020-09-29/4 by sinelun@gmail.com
            The next code constructions (if (false) { // ... ) are intended for excluding original code from the output.
            Remove them to return to the original.
 --  */ ?>

<?php if (false) { // foreach ($totals as $total) { ?>
    <div class="simplecheckout-cart-total" id="total_<?php echo $total['code']; ?>">
        <span><b><?php echo $total['title']; ?>:</b></span>
        <span class="simplecheckout-cart-total-value"><?php echo $total['text']; ?></span>
        <span class="simplecheckout-cart-total-remove">
            <?php if ($total['code'] == 'coupon') { ?>
                <i data-onclick="removeCoupon" title="<?php echo $button_remove; ?>" class="fa fa-times-circle"></i>
            <?php } ?>
            <?php if ($total['code'] == 'voucher') { ?>
                <i data-onclick="removeVoucher" title="<?php echo $button_remove; ?>" class="fa fa-times-circle"></i>
            <?php } ?>
            <?php if ($total['code'] == 'reward') { ?>
                <i data-onclick="removeReward" title="<?php echo $button_remove; ?>" class="fa fa-times-circle"></i>
            <?php } ?>
        </span>
    </div>
<?php } ?>
<?php if (false) { // if (isset($modules['coupon'])) { ?>
    <div class="simplecheckout-cart-total">
        <span class="inputs"><?php echo $entry_coupon; ?>&nbsp;<input class="form-control" type="text" data-onchange="reloadAll" name="coupon" value="<?php echo $coupon; ?>" /></span>
    </div>
<?php } ?>
<?php if (false) { // if (isset($modules['reward']) && $points > 0) { ?>
    <div class="simplecheckout-cart-total">
        <span class="inputs"><?php echo $entry_reward; ?>&nbsp;<input class="form-control" type="text" name="reward" data-onchange="reloadAll" value="<?php echo $reward; ?>" /></span>
    </div>
<?php } ?>
<?php if (false) { // if (isset($modules['voucher'])) { ?>
    <div class="simplecheckout-cart-total">
        <span class="inputs"><?php echo $entry_voucher; ?>&nbsp;<input class="form-control" type="text" name="voucher" data-onchange="reloadAll" value="<?php echo $voucher; ?>" /></span>
    </div>
<?php } ?>

<?php /* -- / sinelun@gmail.com --  */ ?>

<?php if (isset($modules['coupon']) || (isset($modules['reward']) && $points > 0) || isset($modules['voucher'])) { ?>
    <div class="simplecheckout-cart-total simplecheckout-cart-buttons">
        <span class="inputs buttons"><a id="simplecheckout_button_cart" data-onclick="reloadAll" class="button btn-primary button_oc btn"><span><?php echo $button_update; ?></span></a></span>
    </div>
<?php } ?>
<input type="hidden" name="remove" value="" id="simplecheckout_remove">
<div style="display:none;" id="simplecheckout_cart_total"><?php echo $cart_total ?></div>
<?php if ($display_weight) { ?>
    <div style="display:none;" id="simplecheckout_cart_weight"><?php echo $weight ?></div>
<?php } ?>
<?php if (!$display_model) { ?>
    <style>
    .simplecheckout-cart col.model,
    .simplecheckout-cart th.model,
    .simplecheckout-cart td.model {
        display: none;
    }
    </style>
<?php } ?>
</div>