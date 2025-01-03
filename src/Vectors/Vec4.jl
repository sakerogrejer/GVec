# Real Valued 4D Vector Type
mutable struct Vec4{T} <: AbstractVector{T}
    x::T
    y::T
    z::T
    w::T
end

# Constructors
Vec4(x::T) where T = Vec4{T}(x, x, x, x)  # Uniform 4D vector

# Base functions
Base.getindex(v::Vec4, i::Int) = i == 1 ? v.x : i == 2 ? v.y : i == 3 ? v.z : v.w # Get element at index i
Base.setindex!(v::Vec4, val, i::Int) = i == 1 ? (v.x = val) : i == 2 ? (v.y = val) : i == 3 ? (v.z = val) : (v.w = val) # Set element at index i

# Vector operations
dot(v1::Vec4, v2::Vec4) = v1.x * v2.x + v1.y * v2.y + v1.z * v2.z + v1.w * v2.w # Dot product
norm(v::Vec4) = sqrt(v.x^2 + v.y^2 + v.z^2 + v.w^2) # Norm

function normalize(v::Vec4)
    n = norm(v)
    return n == 0 ? Vec4(zero(eltype(v))) : v / n
end

# Arithmetic operations
Base.:+(v1::Vec4, v2::Vec4) = Vec4(v1.x + v2.x, v1.y + v2.y, v1.z + v2.z, v1.w + v2.w) # Addition
Base.:-(v1::Vec4, v2::Vec4) = Vec4(v1.x - v2.x, v1.y - v2.y, v1.z - v2.z, v1.w - v2.w)  # Subtraction
Base.:*(a::T, v::Vec4) where T <: Number = Vec4(a * v.x, a * v.y, a * v.z, a * v.w) # Scalar multiplication
Base.:*(v::Vec4, a::T) where T <: Number = Vec4(a * v.x, a * v.y, a * v.z, a * v.w) # Scalar multiplication
Base.:/(v::Vec4, a::T) where T <: Number = Vec4(v.x / a, v.y / a, v.z / a, v.w / a) # Scalar division
Base.:-(v::Vec4) = Vec4(-v.x, -v.y, -v.z, -v.w) # Negation
Base.:+(v::Vec4, a::T) where T = Vec4(v.x + a, v.y + a, v.z + a, v.w + a) # Add scalar
Base.:-(v::Vec4, a::T) where T = Vec4(v.x - a, v.y - a, v.z - a, v.w - a) # Subtract scalar
Base.:+(a::T, v::Vec4) where T = Vec4(a + v.x, a + v.y, a + v.z, a + v.w) # Add scalar


# Comparison operations
Base.:(==)(v1::Vec4, v2::Vec4) = v1.x == v2.x && v1.y == v2.y && v1.z == v2.z && v1.w == v2.w # Equality
Base.:(!=)(v1::Vec4, v2::Vec4) = !(v1 == v2) # Inequality

Base.abs(v::Vec4) = Vec4(abs(v.x), abs(v.y), abs(v.z), abs(v.w)) # Absolute value
Base.sign(v::Vec4) = Vec4(sign(v.x), sign(v.y), sign(v.z), sign(v.w)) # Sign
Base.min(v1::Vec4, v2::Vec4) = Vec4(min(v1.x, v2.x), min(v1.y, v2.y), min(v1.z, v2.z), min(v1.w, v2.w)) # Element-wise minimum
Base.max(v1::Vec4, v2::Vec4) = Vec4(max(v1.x, v2.x), max(v1.y, v2.y), max(v1.z, v2.z), max(v1.w, v2.w)) # Element-wise maximum
distance(v1::Vec4, v2::Vec4) = norm(v1 - v2) # Distance

# Print
Base.show(io::IO, v::Vec4) = print(io, "Vec4{", eltype(v), "}(", v.x, ", ", v.y, ", ", v.z, ", ", v.w, ")")
Base.show(io::IO, ::MIME"text/plain", v::Vec4) = show(io, v)
Base.show(io::IO, ::MIME"text/html", v::Vec4) = show(io, v)
