package com.whackylabs.photoapp

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.text.KeyboardActions
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.focus.FocusDirection
import androidx.compose.ui.focus.FocusManager
import androidx.compose.ui.platform.LocalFocusManager
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.whackylabs.photoapp.ui.theme.PhotoAppTheme
import java.text.NumberFormat
import kotlin.math.ceil

class TipCalcActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            TipCalcApp()
        }
    }
}

@Composable
fun TipCalcApp() {
    Surface(color = MaterialTheme.colors.background, modifier = Modifier.fillMaxSize()) {
        var amount by remember { mutableStateOf("") }
        var tipPercent by remember { mutableStateOf("10.0") }
        var roundTip by remember { mutableStateOf(false) }
        val tip = calcTip(
            amount = amount.toDoubleOrNull() ?: 0.0,
            tipPercent = tipPercent.toDoubleOrNull() ?: 0.0,
            roundTip = roundTip
        )
        val focusManager = LocalFocusManager.current

        Column(
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.spacedBy(8.dp),
            modifier = Modifier.padding(32.dp)
        ) {
            Text(text = stringResource(id = R.string.tip_calculate), fontSize = 24.sp)
            Spacer(modifier = Modifier.height(16.dp))
            TipField(
                label = stringResource(id = R.string.tip_bill_amount),
                amount = amount,
                imeAction = ImeAction.Next,
                keyboardActions = KeyboardActions(
                    onNext = { focusManager.moveFocus(FocusDirection.Down) }
                ),
                onChange = { amount = it })
            TipField(
                label = stringResource(id = R.string.tip_how_was_the_service),
                amount = tipPercent,
                imeAction = ImeAction.Done,
                keyboardActions = KeyboardActions(
                    onDone = { focusManager.clearFocus() }
                ),
                onChange = { tipPercent = it })
            RoundUpRow(checked = roundTip, onChange = { roundTip = it })
            Spacer(modifier = Modifier.height(24.dp))
            Text(
                text = stringResource(id = R.string.tip_amount, tip),
                fontSize = 20.sp,
                fontWeight = FontWeight.Bold
            )
        }
    }
}

@Composable
fun TipField(
    label: String,
    amount: String,
    imeAction: ImeAction,
    keyboardActions: KeyboardActions,
    onChange: (String) -> Unit
) {
    TextField(
        singleLine = true,
        label = { Text(text = label) },
        keyboardOptions = KeyboardOptions.Default.copy(
            keyboardType = KeyboardType.Number,
            imeAction = imeAction
        ),
        keyboardActions = keyboardActions,
        value = amount,
        onValueChange = onChange
    )
}

@Composable
fun RoundUpRow(checked: Boolean, onChange: (Boolean) -> Unit) {
    Row(verticalAlignment = Alignment.CenterVertically, modifier = Modifier.padding(32.dp)) {
        Text(text = stringResource(id = R.string.tip_round_up_tip))
        Switch(
            checked = checked,
            modifier = Modifier
                .fillMaxWidth()
                .wrapContentWidth(Alignment.End),
            onCheckedChange = onChange
        )
    }
}

fun calcTip(amount: Double, tipPercent: Double, roundTip: Boolean): String {
    var tip = amount * (tipPercent / 100)
    if (roundTip) {
        tip = ceil(tip)
    }
    return NumberFormat.getCurrencyInstance().format(tip)
}

@Preview
@Composable
fun TipCalcPreview() {
    PhotoAppTheme {
        TipCalcApp()
    }
}