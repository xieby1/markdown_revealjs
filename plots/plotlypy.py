#!/usr/bin/env python3
from pathlib import Path
import plotly.graph_objects as go

fig = go.Figure(
    data = [
        go.Bar(x=[1,2,3,4], y=[1,3,1,4])
    ],
)

import plotly.express as px
colors = px.colors.qualitative.Plotly
fig.add_shape(
    type="line",
    line=dict(color=colors[0], width=10),
    x0=2.5, x1=3.5, y0=0.9, y1=0.9,
)
fig.add_shape(
    type="line",
    line=dict(color="white", width=6),
    x0=2.5, x1=3.5, y0=0.9, y1=0.9,
)

# https://stackoverflow.com/questions/29968152/setting-background-color-to-transparent-in-plotly-plots
fig.update_layout(
    template="plotly_white",
    paper_bgcolor="rgba(0,0,0,0)",
    plot_bgcolor="rgba(0,0,0,0)",
    # no margin
    margin=dict(l=0, r=0, t=0, b=0)
)
fig.write_html(Path(__file__).with_suffix(".html"),
    config = {"displayModeBar": False,}, # disable mode bar
    include_plotlyjs="https://cdnjs.cloudflare.com/ajax/libs/plotly.js/2.35.3/plotly.min.js",
    full_html=False,
)
